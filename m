Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275852AbRJGOIA>; Sun, 7 Oct 2001 10:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJGOHy>; Sun, 7 Oct 2001 10:07:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37125 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275852AbRJGOHl>; Sun, 7 Oct 2001 10:07:41 -0400
Subject: Re: %u-order allocation failed
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Sun, 7 Oct 2001 15:12:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        kszysiu@main.braxis.co.uk (Krzysztof Rusocki), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011007141040.1764A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Oct 07, 2001 02:28:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qEfV-0005td-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes - you can run out of vmalloc space. But you run out of it only when
> you create too many processes (8192), load too many modules etc. If
> someone needs to put such heavy load on linux, we can expect that he is
> not a luser and he knows how to increase size of vmalloc space.

Not just that - you get fragmentation of it which leads you back to the
same situation as kmalloc except that with the guard pages you fragment the
address space more.

Alan
