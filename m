Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWA3DP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWA3DP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 22:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWA3DP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 22:15:27 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:49393 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750701AbWA3DPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 22:15:25 -0500
Date: Mon, 30 Jan 2006 12:15:22 +0900
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru,
       rmk@arm.linux.org.uk, spyro@f2s.com, dev-etrax@axis.com,
       dhowells@redhat.com, ysato@users.sourceforge.jp, torvalds@osdl.org,
       linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
       gerg@uclinux.org, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp, ak@suse.de,
       chris@zankel.net, akpm@osdl.org
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Message-ID: <20060130031522.GA6897@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113336.GE18584@miraclelinux.com> <20060126014934.GA6648@miraclelinux.com> <20060127.220401.356433243.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127.220401.356433243.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:04:01PM +0900, Hirokazu Takata wrote:

> compile and boot test on m32r: OK

Thanks.

> Code size became a little bigger...  ;-)
> 
> $ size linux-2.6.16-rc1*/vmlinux
>    text    data     bss     dec     hex filename
> 1768030  124412  721632 2614074  27e33a linux-2.6.16-rc1.bitops/vmlinux
> 1755010  124412  721632 2601054  27b05e linux-2.6.16-rc1.org/vmlinux

The only difference I can find is __ffs()/ffz().
As Russel King clealy pointed out, it will generate larger code
than before.

