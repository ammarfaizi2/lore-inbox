Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUCABXp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUCABXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:23:45 -0500
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:15250 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262213AbUCABXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:23:40 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kernbench v0.30
Date: Mon, 1 Mar 2004 12:23:25 +1100
User-Agent: KMail/1.6
Cc: Cliff White <cliffw@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403011223.31059.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kernbench v0.30

http://ck.kolivas.org/kernbench/

Changelog:
v0.30 Added fast run option which bypasses caching, warmup and tree 
	preparation and drops number of runs to 3. Modified half loads to 
	detect -j2 and change to -j3. Added syncs. Improved warnings and 
	messages. 


What is this?

This is a cpu throughput benchmark originally devised and used by Martin J.
Bligh. It is designed to compare kernels on the same machine, or to compare
hardware. To compare hardware you need to be running the same architecture
machines (eg i386) and run kernbench on the same kernel source tree.

It runs a kernel at various numbers of concurrent jobs: 1/2 number of cpus, 
optimal (default is 4xnumber of cpus) and maximal job count. Optionally it can
also run single threaded. It then prints out a number of useful statistics
for the average of each group of runs.

You need at least 2Gb of ram for this to be a true throughput benchmark or 
else you will get swapstorms.

Ideally it should be run in single user mode on a non-journalled filesystem.
To compare results it should always be run in the same kernel tree.


How do I use it?

You need a kernel tree (any will do) and the applications 'time' and 'awk' 
installed. 'time' is different to the builtin time used by BASH and has more
features desired for this benchmark.
 
Simply cd into the kernel tree directory and type

/path/to/kernbench


Options

kernbench [-n runs] [-o jobs] [-s] [-H] [-O] [-M] [-h] [-v]
n : number of times to perform benchmark (default 5)
o : number of jobs for optimal run (default 4 * cpu)
s : perform single threaded runs (default don't)
H : don't perform half load runs (default do)
O : don't perform optimal load runs (default do)
M : don't perform maximal load runs (default do)
f : fast run
h : print this help
v : print version number


Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAQpCPZUg7+tp6mRURAgvfAJ4lyrnuOns0NSvCY9usWnnhiv2ZpQCbBI04
zvd+1jYdtTwFatWBUEuoERI=
=Eq2l
-----END PGP SIGNATURE-----
