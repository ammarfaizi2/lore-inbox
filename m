Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161869AbWKJP24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161869AbWKJP24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161870AbWKJP24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:28:56 -0500
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:42014 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1161869AbWKJP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:28:55 -0500
Date: Fri, 10 Nov 2006 16:46:00 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       sct@redhat.com, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Message-ID: <20061110154600.GA826@mailshack.com>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <200611091433.09232.ak@suse.de> <20061109183111.GA32438@mailshack.com> <200611101501.40007.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611101501.40007.ak@suse.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Fri, 10 Nov 2006 16:28:53 +0100 (CET)
X-AntiVirus: checked by AntiVir Milter (version: 1.1.3-1; AVE: 7.2.0.39; VDF: 6.36.1.14; host: AntiVir1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 03:01:39PM +0100, Andi Kleen wrote:
> > Hi Andi,
> > 
> > (Assuming you mean: "The gdt table already is 16-byte aligned.")
> > 
> > Hmm. Not in the most recent version of Linus' tree, not even by
> > concidence, and none of the patches in your quilt-current/patches touch
> > x86_64's version of setup.S. Am I missing something?
> 
> The main GDT is. The boot GDT isn't, but it doesn't matter because
> it is only used for a very short time.

Aha, thanks for clearing that up. I agree it is not important to have
the boot GDT aligned, but I think it is preferable to make parts of the
two versions of setup.S equal if possible.

Let's see what Steven Rostedt comes up with.

I find the relocatable image patches interesting. I wonder if one can
get such a kernel 'running' using bochs, freedos, and loadlin ;).

Alexander
