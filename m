Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbRC0Cdz>; Mon, 26 Mar 2001 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbRC0Cdp>; Mon, 26 Mar 2001 21:33:45 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:10759 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S130433AbRC0Cdf>;
	Mon, 26 Mar 2001 21:33:35 -0500
Date: Mon, 26 Mar 2001 19:47:16 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: oops while futzing with nfsboot 2.4.2-ac24
Message-ID: <20010326194716.E59@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This ooops happened while trying to nfsboot a 386, and restarting nfsd
halfway through the boot process. I bet it's not a common problem...

Server is 2.4.2-ac23, client (the Oopser) is 2.4.2-ac24.

The oops is partial because I had to hand-copy from the console, and
it blanked after a few minutes. The client was trying to mount its
root fs at the time (it failed).

-Eric

------

ksymoops 2.4.1 on i586 2.4.2-ac23.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /packages/linux/2.4.2-ac24/i386-nfsroot/boot/System.map (specified)

*pde = 00000000
Oops: 0000
EIP: 0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000 ebx: fffffff4 ecx: c0095420 edx: c0095380
Call Trace: [<c0139c37> <c0139fe7> <c013aa2f> <c012fb22> <c012fe25> <e0108d73>]
Code: Bad EIP value

>>EIP; 00000000 Before first symbol
Trace; c0139c37 <real_lookup+53/c4>
Trace; c0139fe7 <path_walk+223/77c>
Trace; c013aa2f <open_namei+73/570>
Trace; c012fb22 <filp_open+3e/4c>
Trace; c012fe25 <sys_open+45/b8>
Trace; e0108d73 <END_OF_CODE+1fe129ff/????>

