Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRLLQny>; Wed, 12 Dec 2001 11:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRLLQnp>; Wed, 12 Dec 2001 11:43:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S279418AbRLLQnl>; Wed, 12 Dec 2001 11:43:41 -0500
Date: Wed, 12 Dec 2001 16:43:34 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: NFS woes in 2.5.1-pre8
Message-ID: <20011212164334.B16377@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this is expected or not, but I'm seeing odd behaviour with
NFS on 2.5.1-pre8:

[root@assabet bin]$vdir ../lib
-rwxr-xr-x    1       51       51   29091 Dec 12  2001 libts-0.0.so.0.0.0
../lib: Input/output error
[root@assabet bin]$uname -a
Linux assabet 2.5.1-pre8 #69 Mon Dec 10 22:21:15 GMT 2001 armv4l unknown
[root@assabet bin]$

Looking at the NFS traffic:

16:27:09.051301 assabet.arm.linux.org.uk.33f11c24 > raistlin.arm.linux.org.uk.nfs: 148 lookup fh Unknown/1 "libts-0.0.so.0" (DF)
16:27:09.061306 raistlin.arm.linux.org.uk.nfs > assabet.arm.linux.org.uk.33f11c24: reply ok 128 lookup fh Unknown/1 (DF)

Admittedly raistlin is running a rather old, obsolete NFS server, which has
up until now worked faultlessly for around 2 years: Universal NFS Server
2.2beta48

Appologies, but I'm not sure how I got it into this state either - last
thing I had done was to overwrite the files in ../lib and bin with new sets
on the NFS server.  The only directory that is suffering is ../lib.
(there's bin and ../include as well, both of which would've had their
files overwritten with later versions).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

