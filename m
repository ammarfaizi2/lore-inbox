Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVATRWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVATRWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVATRWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:22:11 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:16996 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262396AbVATRVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:21:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=q3X06Aplx6dzLqmuDr7tIag97g0kmkxcwL++vMAATodSeCDTzbYEwinsyBFXp/DLPO0N6ZOzw1DtXDJx9V0JXsYed+HOUzr1Q0REt2kW15xf9UF+eWBZgTT6pTkzrbj1nzlmb0mIUOEC/rgQgL+FfYPYZMV5YzvcFXdHj8tcKck=
Message-ID: <c26b959205012009212138fd49@mail.gmail.com>
Date: Thu, 20 Jan 2005 22:51:03 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Help needed: GCOV - not getting HOW TO!!!
In-Reply-To: <20050119072536.AE66F23CF7@ws5-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050119072536.AE66F23CF7@ws5-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	I got this mail from _someone_ asking me for help on /proc/gcov, I
guess he did not know about lkml. Since I don't know about modules in
linux. I thought of forwarding the mail on to you.





---------- Forwarded message ----------
From: prashanth M D <prashanthmd@indiainfo.com>
Date: Wed, 19 Jan 2005 12:55:36 +0530
Subject: Help needed: GCOV - not getting HOW TO!!!
To: plars@linuxtestproject.org




Hello,

I got your id from google..
I have just started working on kernel code coverage project...

I have patched my kernel and i have configured the gcov kernel module support.
I compilied my module and i run insmod and i got my module executed.
But i am not getting the .da file in /proc/gcov/kernel for my module...
my sample module looks somthing like this,

#include<linux/module.h>
#include<linux/kernel.h>
#include<linux/config.h>

MODULE_LICENSE("GPL");

int init_module (void){

         printk("HELLO WORLD");
         return 0;
}

void cleanup_module (void){

         printk ("In cleanup module NTPL \n");

}

the commands are as follows...

1.  gcc  -D__KERNEL__ -DMODULE -DLINUX -O2 -Wall -Wstrict-prototypes
-fno-strict-aliasing -fno-strict-aliasing
     -c -o test.o -fprofile-arcs -ftest-coverage  test.c

2.  insmod gcov-proc.o

3.  insmod test.o

         This must generate a test.da file in /proc/gcov/kernel/
according to a manual i have but i am not
         getting this file generated...

I am using :
               kernel version linux-2.4.18
               gcc compiler version 3.0.4

Please tell me where i am going wrong.

Please help me out...

Thanking you,

Prashanth M D


--

My gutt feeling after some searches is that the guy forgot to apply the patch 

modutils-2.4.12-gcov.diff 

specified at 
http://ltp.sourceforge.net/coverage/gcov-kernel.readme



-- 

Imanpreet Singh Arora
