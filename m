Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbSLKUog>; Wed, 11 Dec 2002 15:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbSLKUog>; Wed, 11 Dec 2002 15:44:36 -0500
Received: from [213.228.128.56] ([213.228.128.56]:34459 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP
	id <S267310AbSLKUoe>; Wed, 11 Dec 2002 15:44:34 -0500
Date: Wed, 11 Dec 2002 20:56:47 +0000
From: "Paulo Andre'" <fscked@netvisao.pt>
To: linux-kernel@vger.kernel.org
Subject: MTRR refusing to be configured
Message-ID: <20021211205647.GA9472@itsari.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.51 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running kernel 2.5.51 on a Pentium III Katmai processor, stepping 3, 
and I've been trying to properly setup the MTRR registers on it for this  
PCI graphics card. However this has been an unsuccessful quest so far. I 
do have CONFIG_MTRR  turned on and obviously there's the `mtrr' flag on 
/proc/cpuinfo. Taking the base address and the memsize for the card, I've 
tried to do a simple:

# echo "base=0xd8000000 size=0x2000000 type=write-combining" >| /proc/mtrr

However the kernel complains with:

ubik kernel: mtrr: illegal type: "write-combining"

This happens for every other type I choose, be it write-back,
uncachable, well, whatever. Considering this works just fine under a 2.4
kernel (worked on 2.4.19 to be more precise) it's mostly weird that it
doesn't do the same on 2.5.

Oh, I'd appreciate if anyone replying would CC me. Thanks in advance.

Best regards,

		Paulo Andre'

-- 
   That's the difference between me and the rest of the world! Happiness isn't
good enough for me! I demand euphoria!	-- Calvin
