Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263834AbUFBS7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUFBS7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUFBS7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:59:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26019 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263815AbUFBS7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:59:34 -0400
Date: Wed, 2 Jun 2004 19:59:24 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
Message-ID: <20040602185924.GS6302@agk.surrey.redhat.com>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <22Gkd-1AX-17@gated-at.bofh.it> <m3r7sx6dip.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r7sx6dip.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 08:06:06PM +0200, Andi Kleen wrote:
> Alasdair G Kergon <agk@redhat.com> writes:
> > +/*-----------------------------------------------------------------
> > + * Persistent snapshots, by persistent we mean that the snapshot
> > + * will survive a reboot.
> > + *---------------------------------------------------------------*/
 
As opposed to the transient snapshot which is lost on power down.

> Is this target supposed to be crash safe? What happens when
> the computer crashes while writing to such a volume?
 
The intention is for snapshot & origin still to be consistent with each other
on disk.  (No barriers yet, but some synchronous writes.)

Alasdair
-- 
agk@redhat.com
