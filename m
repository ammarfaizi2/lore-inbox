Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277873AbRJRSSt>; Thu, 18 Oct 2001 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277893AbRJRSSj>; Thu, 18 Oct 2001 14:18:39 -0400
Received: from colorfullife.com ([216.156.138.34]:8204 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277873AbRJRSS1>;
	Thu, 18 Oct 2001 14:18:27 -0400
Message-ID: <3BCF1D07.1C54BAAD@colorfullife.com>
Date: Thu, 18 Oct 2001 20:18:47 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch and Performance of larger pipes
In-Reply-To: <3BCF1A74.AE96F241@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------A0B49C5F90BF14A4D4C09CB6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A0B49C5F90BF14A4D4C09CB6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sorry, the patches don't compile - I mixed 2 different versions.
Apply the attached patch on top.

--
	MAnfred
--------------A0B49C5F90BF14A4D4C09CB6
Content-Type: text/plain; charset=us-ascii;
 name="patch-kiopipe2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kiopipe2"

--- 2.4/fs/pipe.c	Thu Oct 18 20:10:13 2001
+++ build-2.4/fs/pipe.c	Thu Oct 18 00:21:08 2001
@@ -113,7 +113,7 @@
 	len = (pio->offset+pio->len+PAGE_SIZE-1)/PAGE_SIZE;
 	down_read(&current->mm->mmap_sem);
 	len = get_user_pages(current, current->mm, (unsigned long)buf, len,
-			0, pio->pages, vmas);
+			0, 0, pio->pages, vmas);
 	if (len > 0) {
 		int i;
 		for(i=0;i<len;i++) {

--------------A0B49C5F90BF14A4D4C09CB6--


