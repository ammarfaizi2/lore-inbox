Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281707AbRKQPpG>; Sat, 17 Nov 2001 10:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281765AbRKQPo5>; Sat, 17 Nov 2001 10:44:57 -0500
Received: from web21101.mail.yahoo.com ([216.136.227.103]:38239 "HELO
	web21101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281707AbRKQPow>; Sat, 17 Nov 2001 10:44:52 -0500
Message-ID: <20011117154448.97910.qmail@web21101.mail.yahoo.com>
Date: Sat, 17 Nov 2001 07:44:48 -0800 (PST)
From: "Roy S.C. Ho" <scho1208@yahoo.com>
Subject: Raw access to block devices
To: linux-kernel@vger.kernel.org
Cc: scho@whizztech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I would like to write a driver for a block device that
is better to be accessed directly without going
through the buffer cache. I read the source code raw.c
and learnt that linux does have raw I/O support.
However, it seems to me that the support only provides
a character device interface to users. Is there a
simple way to maintain the block device interface to
user programs / other parts of the kernel, while
bypassing the buffer cache system?

Since struct block_device_operations does not include
read or write operations, I have considered to
redirect the function pointers in filp->f_op to my own
routines when the device is opened. Is this an
appropriate solution? 

Thank you very much. And please kindly correct me if I
am wrong.

Regards,
Roy Ho

__________________________________________________
Do You Yahoo!?
Find the one for you at Yahoo! Personals
http://personals.yahoo.com
