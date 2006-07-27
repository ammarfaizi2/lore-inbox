Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWG0VTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWG0VTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWG0VTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:19:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62683 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751214AbWG0VTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:19:12 -0400
Date: Thu, 27 Jul 2006 23:18:35 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: 7eggert@gmx.de, Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
Subject: Re: Require mmap handler for a.out executables
In-Reply-To: <1154024752.13509.86.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0607272311020.5867@be1.lrz>
References: <6COYh-8f0-41@gated-at.bofh.it>  <E1G69zn-0001Wb-66@be1.lrz>
 <1154024752.13509.86.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Alan Cox wrote:
> Ar Iau, 2006-07-27 am 19:49 +0200, ysgrifennodd Bodo Eggert:

> > Can shell scripts or binfmt_misc be exploited, too? Even if not, I'd
> > additionally force noexec, nosuid on proc and sysfs mounts.
> 
> Why force them, this is just papering over imagined cracks and running
> from shadows. If users want to be paranoid about these file systems or
> their distro vendor is smart then the ability to set noexec/nosuid is
> already supported and even more can be done with selinux. In fact as its
> usually mounted in one place even AppArmor might be able to get it right
> 8)

s/force/default to/, since it's not OK to let the admin shoot his feet 
unless he _explicitely_ demands to. What if the next crack allows evading 
nosuid by using proc?

Being paranoid doesn't mean they aren't after you ...
-- 
bus error. passengers dumped.
