Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292916AbSBVP43>; Fri, 22 Feb 2002 10:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSBVP4U>; Fri, 22 Feb 2002 10:56:20 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:42850 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S292916AbSBVP4L>;
	Fri, 22 Feb 2002 10:56:11 -0500
Date: Fri, 22 Feb 2002 16:02:50 +0000
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sym53c416 driver breakage
Message-ID: <20020222160250.D241@bleach>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.0
X-OriginalArrivalTime: 22 Feb 2002 15:56:05.0389 (UTC) FILETIME=[6F4F33D0:01C1BBB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes a small bug which prevented the Sym53c416 
driver from compiling. I don't know to which degree this is the right 
fix, since the 'address' field from struct scatterlist just seemed to 
magically disappear. If this was intended, meaning my fix isn't 
correct, I'd like to know about it.


--- linux-2.5.5-dj1/include/asm-i386/scatterlist.h      Fri Feb 22 
15:32:59 2002
+++ linux-dev/include/asm-i386/scatterlist.h    Fri Feb 22 15:29:32 2002
@@ -2,6 +2,7 @@
  #define _I386_SCATTERLIST_H
   struct scatterlist {
+    char               *address;            struct page                
*page;
      unsigned int       offset;
      dma_addr_t         dma_address;



Thanks in advance,

// Paulo Andre'




  /~\ The ASCII
  \ / Ribbon Campaign
   X  Against HTML
  / \ Email!
