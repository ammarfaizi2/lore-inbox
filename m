Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTBCO66>; Mon, 3 Feb 2003 09:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCO66>; Mon, 3 Feb 2003 09:58:58 -0500
Received: from pointblue.com.pl ([62.121.131.135]:30983 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S266772AbTBCO6z>;
	Mon, 3 Feb 2003 09:58:55 -0500
Subject: [BUG] vmalloc, kmalloc - 2.4.x
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1044285222.2396.14.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 15:13:42 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

few days ago i started to port driver for our hardware in company from
windows to linux. It is simple ISA card, which gives me interrupt each
8ms. So i can check it state and latch some sort of watchdog on it -
saying that i am still running (just for security, if system hangs card
is blocking all inputs/outputs). 

But anyway, i was collecting all data from the card in dynamically
allocated memory. This gives me at least 300 * 20 bytes allocated. i
have sigle small allocation running on each interrupt. 

Driver is working fine under win2k even if i collect as much as 10000
allocations, afterwards system uses loads of processor. 

Linux (2.4.19 ,2.4.20, 2.4.21-pre[1,2,3,4] i tried so far) gives me oups
arount 80th allocation.

>From http://hit-six.co.uk/~gj/testmod.tar.bz2 you can download simple
module that shows what happends. But be carefull, it oupses very fast !

system is running up2dated Debian(stable), and i am using gcc version: 
gcc version 2.95.4 20011002 


-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

