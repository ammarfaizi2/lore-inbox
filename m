Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWBHP6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWBHP6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWBHP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:58:04 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:48341 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964997AbWBHP6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:58:02 -0500
Subject: Re: [PATCH] add execute_in_process_context() API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602081618.16974.ak@suse.de>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>
	 <p737j86l1es.fsf@verdi.suse.de>
	 <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
	 <200602081618.16974.ak@suse.de>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 09:57:58 -0600
Message-Id: <1139414279.3003.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 16:18 +0100, Andi Kleen wrote:
> On Wednesday 08 February 2006 16:15, James Bottomley wrote:
> >  The problem is that
> > there's no real way to cope with failure in this case.
> 
> Then you can't use GFP_ATOMIC. You have to redesign.

My mailer seems to have deleted the part of the email with your redesign
suggestion in it...

My initial point is that the current scsi_reap_target() infrastructure
is more broken than the new API, so it does represent an improvement.  I
could also mitigate (but not solve) the problem by adding a wqw slab.
However, I really think the redesign would be along the lines I
suggested to Jens; do you agree?

James


