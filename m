Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266567AbUHINU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbUHINU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUHINUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:20:51 -0400
Received: from bela.bezeqint.net ([192.115.104.7]:10939 "EHLO
	bela.bezeqint.net") by vger.kernel.org with ESMTP id S266561AbUHINUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:20:38 -0400
Date: Mon, 9 Aug 2004 16:22:12 +0300
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: no input with kernel 2.6.8-rc3-mm1 and X
Message-ID: <20040809132212.GA3067@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040808112901.GA2958@luna.mooo.com> <20040808134747.09ff7613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808134747.09ff7613.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040803i
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 01:47:47PM -0700, Andrew Morton wrote:
> Micha Feigin <michf@post.tau.ac.il> wrote:
> >
> > With kernel 2.6.8-rc3-mm1 I lose input completely the moment I start
> > X. Keyboard is completely non-functional (include sysrq and num/ctrl
> > lock) and the touchpad also doesn't seem to produce anything.
> >
> > The computer is otherwise functional and I can ssh in from another
> > machine and chvt to the console where I get the keyboard back. chvt
> > back to X kills input again.
> 
> What interface is the keyboard using?  PS/2?  USB?
> 

Its  laptop built-in keyboard so I am not completely sure , but I
believe it is a ps/2.

> Does the mouse work?  What interface is the mouse using?
> 

The mouse is dead also. It is an alps touchpad using ps/2 interface
using the synaptics driver (along with the patch to support alps, but
also tried without it and didn't change behaviour). Didn't try an
external mouse (I don't use one regularly).

> If you can, try reverting bk-input.patch and see if that fixes it up.  Or
> bk-usb if you're using a USB keyboard.
> 

I backed out bk-input.patch and now things function properly, Thanks.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
