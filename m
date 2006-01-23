Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWAWPP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWAWPP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWAWPP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:15:58 -0500
Received: from main.gmane.org ([80.91.229.2]:64927 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751472AbWAWPP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:15:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: kbuild: problems with separate src/obj trees
Date: Tue, 24 Jan 2006 00:15:04 +0900
Message-ID: <dr2rtq$c4$1@sea.gmane.org>
References: <43D4D708.2050802@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <43D4D708.2050802@suse.de>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann wrote:
>   Hi,
> 
> Trapped into two problems with 2.6.16-rc1:
> 
>   (1) Building kernels with the source tree on a r/o filesystem
>       doesn't work any more because kbuild tries to create
>       $(srctree)/.kernelrelease and fails to do so.
> 
>   (2) UML kernels don't build at all with a separate obj tree:
> 
> master-xen kraxel ~/objtree/vanilla-2.6.16-pre-um# make ARCH=um
> gmake -C /home/kraxel/scratch/vanilla-2.6.16-pre
> O=/home/kraxel/objtree/vanilla-2.6.16-pre-um
>   SYMLINK arch/um/include/kern_constants.h
> ln: creating symbolic link `arch/um/include/kern_constants.h' to
> `../../../include/asm-um/asm-offsets.h': No such file or directory
> gmake[2]: *** [arch/um/include/kern_constants.h] Error 1
> gmake[1]: *** [cdbuilddir] Error 2
> gmake: *** [all] Error 2
> 
> Ideas/Patches anyone?

There was a recen thread about these... let me see:
Look for "[PATCH 2/2] kbuild: fix make -jN with multiple targets with make
O=..." from Sam Ravnborg on 2006-01-16

[It is pushed out at:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git]

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

