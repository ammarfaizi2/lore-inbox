Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSK0UVA>; Wed, 27 Nov 2002 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSK0UU7>; Wed, 27 Nov 2002 15:20:59 -0500
Received: from mail10b.sbc-webhosting.net ([209.238.184.74]:31524 "HELO
	mail10b.sbc-webhosting.net") by vger.kernel.org with SMTP
	id <S264760AbSK0UU7>; Wed, 27 Nov 2002 15:20:59 -0500
Message-ID: <3DE52A93.3060404@hornyaksys.com>
Date: Wed, 27 Nov 2002 15:26:59 -0500
From: Linux Geek <linux-geek@hornyaksys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about copy_from/copy_to
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write a device driver (module) for one of my customers and 
have the following problem.

kernel veraion 2.4.18...

Memory is allocated (kmalloc) in the "open" call.

The above memory is used in copy_from/to in the "ioctl" (and possibly 
the read/write) call.

I understand that the copy_from/to may wait for pages to be swapped in, 
If the waiting process is killed at this point, is it safe to free the 
memory in the "close/release" call? If not, when is it safe to call  kfree?

