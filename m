Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbRGGVd2>; Sat, 7 Jul 2001 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGGVdS>; Sat, 7 Jul 2001 17:33:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266580AbRGGVdD>; Sat, 7 Jul 2001 17:33:03 -0400
Subject: Re: VM in 2.4.7-pre hurts...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 7 Jul 2001 22:33:00 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        riel@conectiva.com.br (Rik van Riel),
        phillips@bonn-fries.net (Daniel Phillips)
In-Reply-To: <Pine.LNX.4.33.0107071046570.31249-100000@penguin.transmeta.com> from "Linus Torvalds" at Jul 07, 2001 10:53:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IzhE-0006Gz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But neutering the OOM killer like Alan suggested may be a rather valid
> approach anyway. Delaying the killing sounds valid: if we're truly
> livelocked on the VM, we'll be calling down to the OOM killer so much that
> it's probably quite valid to say "only return 1 after X iterations".

Its hiding the real accounting screw up with a 'goes bang at random less 
often' - nice hack, but IMHO bad long term approach. We need to get the maths
right. We had similar 2.2 problems the other way (with nasty deadlocks)
until Andrea fixed that


