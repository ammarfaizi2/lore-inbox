Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSKUK7u>; Thu, 21 Nov 2002 05:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKUK7u>; Thu, 21 Nov 2002 05:59:50 -0500
Received: from rakshak.ishoni.co.in ([164.164.83.140]:61523 "EHLO
	arianne.in.ishoni.com") by vger.kernel.org with ESMTP
	id <S266537AbSKUK7t>; Thu, 21 Nov 2002 05:59:49 -0500
Subject: Gnu Linker query
From: Amol Kumar Lad <amolk@ishoni.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 21 Nov 2002 16:36:16 -0500
Message-Id: <1037914591.30043.57.camel@amol.in.ishoni.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Please don't flame for posting in wrong list. I am not receiving any
reply to my query from binutils@srouces.redhat.com. I know people here
will surely help me out.

-- 

 I am using gcc linker on a mips architecture. 
My .text segment for vmlinux starts at 0x80040000 and ends at 0x8010ffff
64K of memory region from 0x80060000 is reserved memory, I do not want
linker to generate any address of .text in this address range. How
should I do it . I tried using MEMORY command like

MEMORY
{  
   rom (!w!x) : ORIGIN = 0x80060000, LENGTH = 64K
}

.text 0x80040000 :
{
  *(.text)
} = 0

but still ld is using address range 0x80060000 (+64K) for .text .

In a nutshell, How do I reserve a memory in one particular section

Please CC me.

Thanks 
Amol



