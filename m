Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292931AbSCMJwy>; Wed, 13 Mar 2002 04:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSCMJwo>; Wed, 13 Mar 2002 04:52:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20233 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S292931AbSCMJwg>; Wed, 13 Mar 2002 04:52:36 -0500
Message-ID: <3C8F210C.C3F1681C@zip.com.au>
Date: Wed, 13 Mar 2002 01:51:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Hill <steve@navaho.co.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in ReiserFS (2.4.17)
In-Reply-To: <Pine.LNX.4.33.0203130921070.31433-100000@sorbus.navaho>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Hill wrote:
> 
> I keep getting ResierFS oopses on my test box here.  It's a Cobalt Raq4i
> running the 2.4.17 kernel (with some of my own experimental code in the
> kernel but I don'tthink this is the cause of the problem).  The box has
> been powercycled and paniced more times than I've had hot dinners so I
> suspect that these oopses are being caused by hard drive corruption.  The
> ksymoops output is below:
> 
> ...
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000006
> ...
> 
> >>EIP; c0134c9d <get_hash_table+5d/90>   <=====
> Trace; c013536f <getblk+1f/50>

One of the buffer_head addresses (which should have been either a
valid address or zero) in fact had a value of 0x00000002.  Single
bit error; probably bad memory/CPU/etc.

-
