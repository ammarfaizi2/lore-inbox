Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTDWNF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTDWNF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:05:29 -0400
Received: from pop.gmx.de ([213.165.65.60]:39661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264024AbTDWNF1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:05:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Stored data missed in setup.S
Date: Wed, 23 Apr 2003 16:17:23 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304231617.23243.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I feel myself stupid, when fighting against setup.S. Here is small piece of 
code (/arch/i386/boot/setup.S)

--->
start_of_setup: # line 160
	# bla bla bla - some checking code
        movb    $1, %al
        movb    %al, (0x100)
....
....
        pushw   %ax
        movb    (0x100), %al
        cmpb    $1, %al
        popw    %ax # pop don't change any flags - 386 asm reference
        je     bail820 # and it don't jump -- al != 1
meme820: # line 300
<---

Any ideas? I've spent two days, trying to understand what's going on - no luck 
at all...

Best regards,
Andrew.
