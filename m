Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbRFPSFC>; Sat, 16 Jun 2001 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbRFPSEw>; Sat, 16 Jun 2001 14:04:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35596 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264637AbRFPSEg>; Sat, 16 Jun 2001 14:04:36 -0400
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 16 Jun 2001 19:02:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), eric@brouhaha.com (Eric Smith),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        arjanv@redhat.com, mj@ucw.cz
In-Reply-To: <3B2B9DA3.3E310BF7@mandrakesoft.com> from "Jeff Garzik" at Jun 16, 2001 01:55:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BKPA-0008O7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> core should be more than just the kissing cousins they are now.  OTOH I
> still don't like how much we trust firmware PCI bus setup on x86..

The BIOS may make assumptions we dont know about such as the bus layout. What
minimises the problem is effectively to validate the firmware provided PCI
setup and if its crap, then do the job ourselves. That minimizes the problems

Hence I think it should not be a define but an __init validator for the bus
setup

