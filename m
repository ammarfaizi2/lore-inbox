Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUJSBuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUJSBuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJSBuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:50:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:20704 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268269AbUJSBuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:50:09 -0400
Subject: Re: Weird... 2.6.9 kills FC2 gcc
From: Mark Haverkamp <markh@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4174697B.90306@pobox.com>
References: <4174697B.90306@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1098150587.1384.0.camel@peabody>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 18 Oct 2004 18:49:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 18:10, Jeff Garzik wrote:
> The following appears in 2.6.9 release kernel, building with stock FC2 
> gcc on x86, but does not appear in 2.6.9-final:
> 
> >   AS      arch/i386/kernel/vsyscall.o
> > cc1: internal compiler error: Segmentation fault
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:http://bugzilla.redhat.com/bugzilla> for instructions.
> > make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
> > make: *** [arch/i386/kernel] Error 2
> 
> 
> 
> This is 100% reproducible, at the same location (vsyscall), which is 
> strange because vsyscall didn't change AFAICS.
> 
> I'll build a gcc 3.4.2 without Fedora Core patches and see if the 
> behavior persists.
> 
> But in the meantime, if anybody else knows what line of code causes this 
> segfault, please speak up :)

As an experiment, I commented out the include of init.h and replaced the
__INITDATA and __FINIT with the .section and .previous.  It then
compiled OK.

Mark.


> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Haverkamp <markh@osdl.org>

