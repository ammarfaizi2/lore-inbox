Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268591AbTCCTh1>; Mon, 3 Mar 2003 14:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268621AbTCCTh1>; Mon, 3 Mar 2003 14:37:27 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:2459 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S268591AbTCCTh0>; Mon, 3 Mar 2003 14:37:26 -0500
Message-ID: <3E63B172.8070402@myrealbox.com>
Date: Mon, 03 Mar 2003 11:48:02 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5-ac1: one old problem, one new problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

First, I'm still seeing the same problem with swapoff -a which started with
-pre4-ac7.

# swapoff -a
Unable to handle kernel paging request at virtual address 00001000
   printing eip:
c014b5c1
*pde=000000000
Oops: 2
[lots of hex numbers snipped]
</sbin/swapoff segfaults>

The oops doesn't shut down the system -- everything continues on as if
nothing had happened.  The swapspace is disabled and can be re-enabled
with swapon as desired.

Also, if I specify the swap partition by name instead of using the -a flag
to swapoff, everything works normally.  Something about the -a flag causes
the problem.

Second (new) problem:
My Broadcom Tigon network chip doesn't work with -pre5-ac1, but it did
work just fine with pre4-ac7 and earlier.  It shows up in 'ifconfig' as
usual but I can't ping or connect to any machine other than localhost.

I'm happy to supply any other information you may need.  Just let me know
if I should provide more info.

Anyone else seeing these problems?


