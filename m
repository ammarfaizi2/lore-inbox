Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUAEWXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbUAEWV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:21:57 -0500
Received: from viruswall.ccf.swri.edu ([129.162.252.34]:5619 "EHLO
	viruswall.ccf.swri.edu") by vger.kernel.org with ESMTP
	id S265964AbUAEWUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:20:19 -0500
Date: Mon, 05 Jan 2004 16:20:15 -0600
From: Chris Smith <chris.smith@swri.org>
Subject: ld.so kernel difference
To: linux-kernel@vger.kernel.org
Message-id: <7bf757ae92.7ae927bf75@swri.org>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.17 (built Jun 23 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system booting via pxe using a kernel built from redhat source (2.4.20-8). I am trying to get the system to boot using a kernel.org kernel. (one of many 2.4.22, 23, 20) 

This system is very stripped down, no disks. ~12MB for the full running os. essentially the init is the only thing running. it starts various daemons then loops on a bash propmt.

What I am seeing (and why i sent it to this list) is that there appears to be a difference in how the libraries are being found between the two types of kernels. the redhat derived kenrel is working but none of the kernel.org kernels are. 

the error i am seeing with the kenrel.org kernels is: 
/bin/sh: error while loading shared libraries libc.so.6: cannot open shared object file: no such file or directory.

then it tries to kill the init and the kernel panics.

is there a way the kernel can influence how/where ld.so looks for a library? the libraries are present on the ramdisk just not found by the kernel. the kernel is accessing the ramdisk since it is trying to run the init script (it is failing on loading /bin/sh since this is not statically linked). the "redhat" kernel using the same ramdisk works fine (same ld.so.cache, etc).

??

chris

