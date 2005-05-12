Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVELLrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVELLrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 07:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVELLrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 07:47:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:26791 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261498AbVELLrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 07:47:00 -0400
Date: Thu, 12 May 2005 13:46:57 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050512114657.GD15690@wotan.suse.de>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115892008.918.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 12:00:08PM +0200, Alexander Nyberg wrote:
> tor 2005-05-12 klockan 10:27 +0200 skrev Jan Beulich:
> > (Note: Patch also attached because the inline version is certain to get
> > line wrapped.)
> > 
> > Get the x86-64 watchdog tick calculation into a state where it can also
> > be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
> > default (as is already done on i386).
> > 
> 
> Why shouldn't the watchdog be turned on by default? It's an extremely
> useful debugging aid and it's not like it fires NMIs often (the nmi_hz
> is far from reality).

I agree, I definitely want to keep the watchdog enabled by default.
It is a invaluable debugging aid.

The only reason i386 has it turned off by default is that it did not
always work on some oudated hardware. Needs to be probably revisited
at some point too.

-Andi
