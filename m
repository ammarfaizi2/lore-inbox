Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbTLRU2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265380AbTLRU2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:28:01 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:34697 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265379AbTLRU16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:27:58 -0500
Date: Thu, 18 Dec 2003 21:28:36 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0 setup.S assembler messages
Message-ID: <20031218202836.GA13575@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this a while ago but got no replies. When I compiled 2.6.0 today,
the warning was still there, so I felt that a repost might be useful for
someone.

I thought it would be best to report this warning I get at the 
very end of the compiling-process. I'm no programmer or kernel- 
developer, so there is no way for me to tell of what significance 
this is. 

Anyway, I get this message even after a 'make mrproper', so I'm 
quite sure it's not a problem with old junk-files or something. 
When I look in setup.S at line 165, I find nothing but a reference 
to MAXMEM-1 or something like that, and it does seem odd that the 
value gets truncated into an identical value (unless the value was 
truncated before the message got printed, that is). 

--------------------------------------- 
AS arch/i386/boot/setup.o 
	arch/i386/boot/setup.S: Assembler messages: 
	arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff
LD arch/i386/boot/setup 
--------------------------------------- 

I'm running i386-systems with the 2.6.0-kernel. I got the same 
message on two different computers, one AMD Athlon TBird, and one 
Intel Celeron. 

Is this a known problem, and is there a fix to this somehow?

-- 
Tim Cambrant <tim@cambrant.com> 
GPG KeyID 0x59518702
Fingerprint: 14FE 03AE C2D1 072A 87D0  BC4D FA9E 02D8 5951 8702
