Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbTAMQTi>; Mon, 13 Jan 2003 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267631AbTAMQTi>; Mon, 13 Jan 2003 11:19:38 -0500
Received: from web13709.mail.yahoo.com ([216.136.175.251]:64086 "HELO
	web13709.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267619AbTAMQTh>; Mon, 13 Jan 2003 11:19:37 -0500
Message-ID: <20030113162827.46498.qmail@web13709.mail.yahoo.com>
Date: Mon, 13 Jan 2003 08:28:27 -0800 (PST)
From: Mad Hatter <slokus@yahoo.com>
Subject: bootsect.S: 2 questions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking through the linux (2.5.56) arch/i386/boot/bootsect.S and was
puzzled about a couple of things:

1. Near line 221 we have:
       sread:  .word 0             # sectors read of current track
       head:   .word 0             # current head
       track:  .word 0             # current track

   However, since a diskette can have at most 2 heads, 80 tracks and 36 sectors
   per track, why are these not bytes instead of words especially since space is
   at such a tight premium in this code ?

2. Near line 272 we have "movw    $7, %bx" but the documentation I've
    been able to find about the "int 0x10" BIOS call says that for service
    code 0xe (write character and advance cursor), it does not take an
    attribute byte input parameter but rather uses the existing attribute. Is
    this movw instruction superfluous ?

Thanks. 

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
