Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGTHX>; Wed, 7 Feb 2001 14:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBGTHO>; Wed, 7 Feb 2001 14:07:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129907AbRBGTG7>; Wed, 7 Feb 2001 14:06:59 -0500
Subject: Re: PCI-SCI Drivers v1.1-7 released
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Wed, 7 Feb 2001 19:06:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010207111900.E27089@vger.timpanogas.org> from "Jeff V. Merkey" at Feb 07, 2001 11:19:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QZvc-00013n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I looked into this, and discovered that the gcc 2.96 compiler turned my 
> rep movsd code into a rep movsb (???) with some evil looking C++ style 

If its hand coded asm then gcc shouldnt have touched it. If its an implicit
memcpy then gcc will generate inline code designed for main memory copying.

Do you have a small example chunk of code showing this ?

> They deviated by 30%, indicating that my MTRR write combining optimization
> was not working properly in sci copy mode.  

That would explain the %age certainly. How it happened is the next question

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
