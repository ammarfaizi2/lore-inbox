Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRDKIPb>; Wed, 11 Apr 2001 04:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132529AbRDKIPT>; Wed, 11 Apr 2001 04:15:19 -0400
Received: from mail0.hongkong.com ([202.84.12.153]:29182 "HELO hongkong.com")
	by vger.kernel.org with SMTP id <S132530AbRDKIOi>;
	Wed, 11 Apr 2001 04:14:38 -0400
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-ID: <Eq989588839292.22828@mail2.hongkong.com>
Date: Wed, 11 Apr 2001 16:07:07 +0800 (CST)
From: antonpoon@hongkong.com
To: linux-kernel@vger.kernel.org
Subject: How can I add a function to the kernel initialization
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a driver for a character set LCD module using parallel port. I want to display a message when the kernel is initialized. 

I added the following to start_kernel() in init/main.c

#include <stdio.h>

{
  int i;
  char line = "Loading Kernel";
  FILE *ptr;
  ptr = fopen("/dev/lcd","w");
  
  for (i=0;i<10;i++)
  {
  	fprintf(ptr, "%s\n", line);
  }
  fclose(ptr);
}
   
Error was found, it looks like that it can not include stdio.h in the initialization.
How can I do that?

I wish to be personally CC'ed the answers/comments posted to the list in response to my posting. Thank you.

Best Regards,
Anton



---------------------------------------------
 歡迎使用HongKong.com郵件系統
 Thank you for using hongkong.com Email system

