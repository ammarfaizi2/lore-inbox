Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTJPAUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 20:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTJPAUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 20:20:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:25805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261892AbTJPAUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 20:20:14 -0400
Date: Wed, 15 Oct 2003 17:19:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: George R Goffe <grgoffe@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A problem I'm having with mkinitrd for linux-2.6-test7
Message-Id: <20031015171910.604cfad6.rddunlap@osdl.org>
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

| I have built a linux 2.6-test7 kernel on my redhat 8.0 system and am trying to
| use mkinitrd. I am getting this message relating to a module not being found
| (see command and error message below).
| 
| I'm not sure what to do at this point. The make modules produced no problems
| but make modules_install had a bunch of depmod problems. I have been using the
| module-init-tools-0.9.15-pre2 tools from Rusty's site.
| 
| Any/all help/tips/hints/suggestions would be greatly appreciated.
| 
| 
| 2.4.20-20.8smp root->server3# mkinitrd /boot/initrd-2.6.0-test7.img
| 2.6.0-test7
| No module mptbase found for kernel 2.6.0-test7

The 'mkinitrd' script is probably different on our systems.  I expect
that distros customize it a bit and I don't have a RH 8.0 version
of it.

The latest version that I found (3.5.14) searches for module files
ending in o.gz, o, or ko.  I expect that you are using a version of
mkinitrd that does not search for module files ending in ko.
You (or I) could modify your mkinitrd file to search for ko module
names, or you could try an updated version of mkinitrd that does
search for modules names that end with ko.

Do you actually want/need the mptbase module in your initrd?
If not, edit /etc/modules.conf and remove that module name.
But mkinitrd needs to be updated to look in /etc/modprobe.conf
instead of /etc/modules.conf for module names.  I expect that
the distros will take care of that.

--
~Randy
