Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRDNLsg>; Sat, 14 Apr 2001 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRDNLs1>; Sat, 14 Apr 2001 07:48:27 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:16770 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S132038AbRDNLsY>; Sat, 14 Apr 2001 07:48:24 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: vivid_liou@dlink.com.tw
cc: linux-kernel@vger.kernel.org
Subject: Re: why can't include /sys/types and /linux/fs.h in the same file 
In-Reply-To: Message from vivid_liou@dlink.com.tw 
   of "Sat, 14 Apr 2001 19:39:16 +0800." <48256A2E.003F9F29.00@dlink.com.tw> 
In-Reply-To: <48256A2E.003F9F29.00@dlink.com.tw> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Apr 2001 12:47:41 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14oOWj-0008L7-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>#include <kernel/fs.h>
>#include <sys/types.h>
>int main ()
>{
>;  // contains no C programs,
>}
>and give the command " cc  -D__KERNEL__ -I/usr/src/linux/include  to compiler
>the program .

You can't mix environments.  Either you're building part of the kernel, in which 
case you need to use -D__KERNEL__ and <linux/*> headers, or you're building an 
application, in which case you need to use the headers from libc.

p.


