Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTJOXJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTJOXJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:09:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:46244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbTJOXJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:09:21 -0400
Date: Wed, 15 Oct 2003 16:08:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: George R Goffe <grgoffe@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A problem I'm having with mkinitrd for linux-2.6-test7
Message-Id: <20031015160817.7a98324c.rddunlap@osdl.org>
In-Reply-To: <20031015202709.38652.qmail@web21307.mail.yahoo.com>
References: <20031015202709.38652.qmail@web21307.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 13:27:09 -0700 (PDT) George R Goffe <grgoffe@yahoo.com> wrote:

| Howdy,
| 
| I have built a linux 2.6-test7 kernel on my redhat 8.0 system and am trying to
| use mkinitrd. I am getting this message relating to a module not being found
| (see command and error message below).
| 
| I'm not sure what to do at this point. The make modules produced no problems
| but make modules_install had a bunch of depmod problems. I have been using the
| module-init-tools-0.9.15-pre2 tools from Rusty's site.

Compare 'depmod -V' from your user login prompt to
'depmod -V' when logged in (or 'su') as root.

There shouldn't be these depmod errors, and I've seen at least one
case of root's depmod being the old modutils one instead of
the one from module-init-tools (this being a $PATH issue).

| Any/all help/tips/hints/suggestions would be greatly appreciated.
| 
| Regards,
| 
| George...
| 
| 2.4.20-20.8smp root->server3# mkinitrd /boot/initrd-2.6.0-test7.img
| 2.6.0-test7
| No module mptbase found for kernel 2.6.0-test7

Someone else also reported this problem with mptbase and mkinitrd....
I'll look at the mkinitrd script to see if anything pokes me in the eye.

--
~Randy
