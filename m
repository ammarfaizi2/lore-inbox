Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275811AbRJFWmd>; Sat, 6 Oct 2001 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275808AbRJFWmX>; Sat, 6 Oct 2001 18:42:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53777 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275798AbRJFWmO>; Sat, 6 Oct 2001 18:42:14 -0400
Subject: Re: %u-order allocation failed
To: mikulas@artax.karlin.mff.cuni.cz
Date: Sat, 6 Oct 2001 23:42:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), anton@samba.org (Anton Blanchard),
        riel@conectiva.com.br (Rik van Riel),
        kszysiu@main.braxis.co.uk (Krzysztof Rusocki), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011007002406.18004A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Oct 07, 2001 12:31:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15q09C-0002X7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nothing dangeorus there. The -ac vm isnt triggering these cases.
> 
> Sorry, but it can be triggered by _ANY_ VM since buddy allocator was
> introduced. You have no guarantee, that you find two or more consecutive
> free pages. And if you don't, poll() fails. 

The two page case isnt one you need to worry about. To all intents and
purposes it does not happen, and if you do the maths it isnt going to fail
in any interesting ways. Once you go to the 4 page set the odds get a lot
longer and then rapidly get very bad indeed,

Alan
