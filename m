Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268699AbRGZWGi>; Thu, 26 Jul 2001 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268700AbRGZWGT>; Thu, 26 Jul 2001 18:06:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20754 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268699AbRGZWGJ>; Thu, 26 Jul 2001 18:06:09 -0400
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
To: linux-kernel@alex.org.uk
Date: Thu, 26 Jul 2001 23:06:02 +0100 (BST)
Cc: engler@csl.Stanford.EDU (Dawson Engler),
        alan@lxorguk.ukuu.org.uk (Alan Cox), nave@stanford.edu (Evan Parker),
        linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
In-Reply-To: <602725597.996180886@[169.254.62.211]> from "Alex Bligh - linux-kernel" at Jul 26, 2001 08:54:48 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PtGc-0004ad-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> How will this be guaranteed to help handle a race, when gcc is
> likely either to have tmp_buf in a register (not declared
> volatile), or perhaps even optimize out the second reference.

The function call is a synchronization point, and the function it calls
might change the value. I put the barriers into my tree to make this clear
although I cant see some future super gcc globally optimising that one
anyway

Alan
