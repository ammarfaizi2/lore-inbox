Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTIQFph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTIQFph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:45:37 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:44673
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S262679AbTIQFpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:45:35 -0400
Message-Id: <200309170545.h8H5jMTq011596@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: John Cherry <cherry@osdl.org>
cc: Randy Dunlap <rddunlap@osdl.org>, reg@dwf.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reg@orion.dwf.com
Subject: Re: 2.6.0-test5: "No module aic7xxx found for kernel 2.6.0-test5, 
 aborting."
In-Reply-To: Message from John Cherry <cherry@osdl.org> 
   of "16 Sep 2003 10:46:53 PDT." <1063734412.20156.2.camel@cherrytest.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Sep 2003 23:45:22 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> --=-qKbn9YnrwluGdEN58xpj
> Content-Type: text/plain
> Content-Transfer-Encoding: 7bit
> 
> Are you compiling with anything other than -j1?  There is a race in the
> parallel build of aic7xxx.  A patch has been submitted, but is not in
> -test5.
> 
> Try the attached patches and see if this helps you.
> 
> John
> 
Well, yes, I was using either -j2 or -j4 (on a single processor machine).
[[ Somehow, the 2.6.0 compiles seem REALLY SLOW compared to the 2.4.x and
previous compiles ]].

But the patch didnt seem to solve the problem, I still see:

Root device is (3, 7)
Boot sector 512 bytes.
Setup is 2544 bytes.
System is 1826 kB
Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
No module aic7xxx found for kernel 2.6.0-test5
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2

when I type 'make install'.  The 'make bzImage' itself went just fine.
This was after a 'make mrproper'.

As suggest (by someone else) I guess I can just do the install by hand,
but this dependence on aic7xxx is VERY strange.




-- 
                                        Reg.Clemens
                                        reg@dwf.com


