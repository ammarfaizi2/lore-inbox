Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbTCTM5j>; Thu, 20 Mar 2003 07:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbTCTM5i>; Thu, 20 Mar 2003 07:57:38 -0500
Received: from web41304.mail.yahoo.com ([66.218.93.53]:64668 "HELO
	web41304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261439AbTCTM53>; Thu, 20 Mar 2003 07:57:29 -0500
Message-ID: <20030320130824.30748.qmail@web41304.mail.yahoo.com>
Date: Fri, 21 Mar 2003 01:08:24 +1200 (NZST)
From: =?iso-8859-1?q?thomas=20joseph?= <thomascanny@yahoo.co.nz>
Subject: remap_page_range an caching
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

 I am using remap_page_range to map a memory region
 to user space. (This is a device memory mapped in 
 to kernel space by ioremap_nocache.)

 I am setting the page protection flags as
  _PAGE_PCD | _PAGE_PWT to disable caching as 
  specified in the  documentation. 

  But when I try to read these device registers in the
  user space it shows different values from
  those of driver. I declared the necessary
  members as volatile. But it still does not help.

  When I try to read the register twice I seem to be
getting the correct value. 

  Like,
   /* ulBWStatus is defined as volatile. */
   status = pRpRegs->ulBStatus;
   status = pRpRegs->ulBStatus;
This gives me the updated values. Could you
just help me if I am missing anything here.

 D0 I need to insert a memory barrier in the user
space
 before accessing these registers ?
 If I do so then it looks like giving correct values
too.


 Could somebody help to understand on what is
happening here.

Thanks in advance.

best regards,

 --thomas







 

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
