Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278151AbRJRV0D>; Thu, 18 Oct 2001 17:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278136AbRJRVZx>; Thu, 18 Oct 2001 17:25:53 -0400
Received: from cs.columbia.edu ([128.59.16.20]:31688 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S278121AbRJRVZi>;
	Thu, 18 Oct 2001 17:25:38 -0400
Date: Thu, 18 Oct 2001 17:26:10 -0400 (EDT)
From: Shaya Potter <spotter@cs.columbia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: xircom_cb and promiscious mode
Message-ID: <Pine.GSO.4.31.0110181725190.764-100000@diamond.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been having some problems with the xircom_cb driver here at
columbia for the past few weeks.  It finally dawned on me that the problem
might be because dmesg kept on telling me that driver was going into
promiscious mode (and ifconfig show me a high RX value (after only a few
moments of the card being up)).  I did't have any problems on my small
network at home, but I'm guessing a problem b/w the switch here at school
and the card being in promiscious mode basically made the card useless in
linux (worked fine in win2k)

in looking through the source for the driver, it seems from the comments
that when the card is in interrupt handler mode, it has to turn
promiscious mode on.  I don't know why, but I do know that it never seems
to turn it off.  I basically stuck a return in the enable_promisc function
before it does anything, and that cleared up all my problems.

I'm guessing this is not the correct solution (based on the comment), so
if someone who has a better idea of how network card drivers work, I'd
appreciate some insight.

thanks,

shaya potter
-- 
spotter@{cs.columbia.edu,yucs.org}

