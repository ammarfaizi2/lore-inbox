Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUIONZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUIONZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUIONZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:25:36 -0400
Received: from gandalf.ios.edu.pl ([193.0.91.125]:5049 "EHLO
	gandalf.ios.edu.pl") by vger.kernel.org with ESMTP id S261375AbUIONZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:25:31 -0400
Message-ID: <414844C5.6080802@ios.edu.pl>
Date: Wed, 15 Sep 2004 15:33:57 +0200
From: =?ISO-8859-2?Q?Marcin_Ro=BFek?= <marcin.rozek@ios.edu.pl>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c
References: <414834AA.70602@ios.edu.pl> <20040915112102.GA1992@logos.cnet>
In-Reply-To: <20040915112102.GA1992@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-From: marcin.rozek@ios.edu.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Its the third or fourth report like this I see, all of them with the 
> grsecurity patch applied.
> 
> Have you tried a stock 2.4.27?
No.
Is that bug serious? Should i move to clean 2.4.27?

Strange is that previously i've been running (for quite long time) Mandrake 9.1 
on the same machine with 2.4.27-grsec (but with enabled 
CONFIG_GRKERNSEC_PAX_MPROTECT) and i don't remember seeing such BUG...

Here're my grsecurity settings:

CONFIG_GRKERNSEC=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_SHA256=y
# CONFIG_GRKERNSEC_LOW is not set
# CONFIG_GRKERNSEC_MID is not set
# CONFIG_GRKERNSEC_HI is not set
CONFIG_GRKERNSEC_CUSTOM=y
CONFIG_GRKERNSEC_PAX_EI_PAX=y
CONFIG_GRKERNSEC_PAX_PT_PAX_FLAGS=y
CONFIG_GRKERNSEC_PAX_NO_ACL_FLAGS=y
# CONFIG_GRKERNSEC_PAX_HAVE_ACL_FLAGS is not set
# CONFIG_GRKERNSEC_PAX_HOOK_ACL_FLAGS is not set
CONFIG_GRKERNSEC_PAX_NOEXEC=y
# CONFIG_GRKERNSEC_PAX_PAGEEXEC is not set
CONFIG_GRKERNSEC_PAX_SEGMEXEC=y
# CONFIG_GRKERNSEC_PAX_EMUTRAMP is not set
# CONFIG_GRKERNSEC_PAX_MPROTECT is not set
CONFIG_GRKERNSEC_PAX_ASLR=y
# CONFIG_GRKERNSEC_PAX_RANDKSTACK is not set
CONFIG_GRKERNSEC_PAX_RANDUSTACK=y
CONFIG_GRKERNSEC_PAX_RANDMMAP=y
# CONFIG_GRKERNSEC_KMEM is not set
# CONFIG_GRKERNSEC_IO is not set
CONFIG_GRKERNSEC_PROC_MEMMAP=y
CONFIG_GRKERNSEC_BRUTE=y
CONFIG_GRKERNSEC_HIDESYM=y
CONFIG_GRKERNSEC_ACL_HIDEKERN=y
CONFIG_GRKERNSEC_ACL_MAXTRIES=3
CONFIG_GRKERNSEC_ACL_TIMEOUT=30
CONFIG_GRKERNSEC_PROC=y
CONFIG_GRKERNSEC_PROC_USER=y
CONFIG_GRKERNSEC_PROC_ADD=y
CONFIG_GRKERNSEC_LINK=y
CONFIG_GRKERNSEC_FIFO=y
CONFIG_GRKERNSEC_CHROOT=y
CONFIG_GRKERNSEC_CHROOT_MOUNT=y
CONFIG_GRKERNSEC_CHROOT_DOUBLE=y
CONFIG_GRKERNSEC_CHROOT_PIVOT=y
CONFIG_GRKERNSEC_CHROOT_CHDIR=y
CONFIG_GRKERNSEC_CHROOT_CHMOD=y
CONFIG_GRKERNSEC_CHROOT_FCHDIR=y
CONFIG_GRKERNSEC_CHROOT_MKNOD=y
# CONFIG_GRKERNSEC_CHROOT_SHMAT is not set
CONFIG_GRKERNSEC_CHROOT_UNIX=y
# CONFIG_GRKERNSEC_CHROOT_FINDTASK is not set
# CONFIG_GRKERNSEC_CHROOT_NICE is not set
CONFIG_GRKERNSEC_CHROOT_SYSCTL=y
# CONFIG_GRKERNSEC_CHROOT_CAPS is not set
# CONFIG_GRKERNSEC_AUDIT_GROUP is not set
# CONFIG_GRKERNSEC_EXECLOG is not set
# CONFIG_GRKERNSEC_RESLOG is not set
# CONFIG_GRKERNSEC_CHROOT_EXECLOG is not set
# CONFIG_GRKERNSEC_AUDIT_CHDIR is not set
# CONFIG_GRKERNSEC_AUDIT_MOUNT is not set
# CONFIG_GRKERNSEC_AUDIT_IPC is not set
CONFIG_GRKERNSEC_SIGNAL=y
CONFIG_GRKERNSEC_FORKFAIL=y
CONFIG_GRKERNSEC_TIME=y
# CONFIG_GRKERNSEC_PROC_IPADDR is not set
CONFIG_GRKERNSEC_EXECVE=y
CONFIG_GRKERNSEC_DMESG=y
CONFIG_GRKERNSEC_RANDPID=y
# CONFIG_GRKERNSEC_TPE is not set
CONFIG_GRKERNSEC_RANDNET=y
CONFIG_GRKERNSEC_RANDISN=y
CONFIG_GRKERNSEC_RANDID=y
CONFIG_GRKERNSEC_RANDSRC=y
CONFIG_GRKERNSEC_RANDRPC=y
# CONFIG_GRKERNSEC_SOCKET is not set
# CONFIG_GRKERNSEC_SYSCTL is not set
CONFIG_GRKERNSEC_FLOODTIME=10
CONFIG_GRKERNSEC_FLOODBURST=4

