Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVCaEUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVCaEUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVCaEUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:20:30 -0500
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:29253 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261948AbVCaERT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:17:19 -0500
Date: Wed, 30 Mar 2005 23:16:46 -0500
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: 2.6.12-rc1-mm3: class_simple API
In-reply-to: <200503310319.j2V3JhXJ009858@turing-police.cc.vt.edu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Mail-followup-to: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Message-id: <20050331041646.GA24665@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.8i
References: <20050327180431.GA4327@nikolas.hn.org>
 <200503310319.j2V3JhXJ009858@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 10:19:42PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 27 Mar 2005 13:04:31 EST, Nick Orlov said:
> 
> > Problem is that the latest bk-driver-core patch included in the 2.6.12-rc1-mm3
> > removes class_simple API without providing EXPORT_SYMBOL'ed (as opposed to
> > EXPORT_SYMBOL_GPL) alternative.
> > 
> > As the result I don't see a way how out-of-the-kernel non-GPL drivers
> > (nvidia in my case) could be fixed.
> 
> Umm.. try running the latest drivers?
> 
> [~]2 uname -a
> Linux turing-police.cc.vt.edu 2.6.12-rc1-mm3 #1 PREEMPT Sat Mar 26 22:07:50 EST 2005 i686 i686 i386 GNU/Linux
> [~]2 lsmod | grep nvidia
> nvidia               3912636  14 
> agpgart                25672  2 nvidia,intel_agp
> [~]2 grep -i nvidia /var/log/kernmsg
> Mar 30 21:58:19 turing-police kernel: [4294721.402000] nvidia: module license 'NVIDIA' taints kernel.
> Mar 30 21:58:19 turing-police kernel: [4294721.434000] NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7167  Fri Feb 25 09:08:22 PST 2005
> 

I _am_ using the latest NVIDIA driver:

nick@nikolas:~$ dmesg | grep NVIDIA
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7167  Fri Feb
25 09:08:22 PST 2005

nick@nikolas:~$ ll /lib/modules/`uname -r`/nvidia
total 4315
-rw-r--r--  1 root root 4399395 2005-03-27 12:29 nvidia.ko

If you are not relying on udev being able to create nvidia device nodes
you are not affected.

-- 
With best wishes,
	Nick Orlov.

