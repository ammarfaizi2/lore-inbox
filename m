Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSF1Nt3>; Fri, 28 Jun 2002 09:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317395AbSF1Nt2>; Fri, 28 Jun 2002 09:49:28 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:57535 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317361AbSF1Nt1>;
	Fri, 28 Jun 2002 09:49:27 -0400
Subject: [PATCH] compile fix for 2.5 kdev_t compatibility macros
From: Stephen Lord <lord@sgi.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jun 2002 08:50:30 -0500
Message-Id: <1025272233.1168.21.camel@n236>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo,

We started using these for XFS, and found a missing bracket, patch
against 2.4.19-rc1.

Steve

*** linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 08:40:22 2002
--- linux/include/linux/kdev_t.h	Fri Jun 28 07:05:32 2002
***************
*** 81,87 ****
  #define minor(d)	MINOR(d)
  #define kdev_same(a,b)	((a) == (b))
  #define kdev_none(d)	(!(d))
! #define kdev_val(d)	((unsigned int)(d)
  #define val_to_kdev(d)	((kdev_t(d))
  
  /*
--- 81,87 ----
  #define minor(d)	MINOR(d)
  #define kdev_same(a,b)	((a) == (b))
  #define kdev_none(d)	(!(d))
! #define kdev_val(d)	((unsigned int)(d))
  #define val_to_kdev(d)	((kdev_t(d))
  
  /*

