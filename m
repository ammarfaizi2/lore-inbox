Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTLZObN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 09:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbTLZObN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 09:31:13 -0500
Received: from sina187-143.sina.com.cn ([202.106.187.143]:39953 "HELO sina.com")
	by vger.kernel.org with SMTP id S265188AbTLZObL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 09:31:11 -0500
Date: Fri, 26 Dec 2003 22:30:21 +0800
From: dlion <dlion2004@sina.com.cn>
X-Mailer: The Bat! (v2.00)
Reply-To: dlion2004@sina.com.cn
X-Priority: 3 (Normal)
Message-ID: <17140565218.20031226223021@sina.com.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
In-Reply-To: <8BD3ED34-37A6-11D8-A9B5-00039341E01A@ybb.ne.jp>
References: <8BD3ED34-37A6-11D8-A9B5-00039341E01A@ybb.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

Friday, December 26, 2003, 9:22:25 PM, you wrote:

Bxynj> Hi,

 >>I got other errors on ext3 filesystem include:
 >>1. missing file
 >>2. corrupted file
 >>but when I used fsck.ext3 to check the ramdisk, the result was clean.

Bxynj> Dlion,  how did the corrupted file look like?
Bxynj> (its file size, number of blocks etc.)

1. some corrupted files is truncated to 0 bytes. Blockcount is 0.

2. some corrupted files is truncated . the result is a shorter file.
the new size is multiple of block size.

3. maybe all corrupted files' mtime is exactly the same
wrong value. Should be around 2003.12.26 21:30:00, but
is 2002.05.12 12:00:48(hex value is 0x3cdde8f0) . ctime
and atime is correct. The system's clock time is unchanged.

4. it seems that the corrupted files tends to exist in the same
directory.

Use a 128000k bytes ramdisk you can get these results in less than
30 minutes. BTW, your test script is very good. Thank you.



