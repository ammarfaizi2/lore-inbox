Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSCHTF3>; Fri, 8 Mar 2002 14:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311012AbSCHTFT>; Fri, 8 Mar 2002 14:05:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20239 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311023AbSCHTFD>; Fri, 8 Mar 2002 14:05:03 -0500
Subject: Re: gettimeofday() system call timing curiosity
To: root@chaos.analogic.com
Date: Fri, 8 Mar 2002 19:19:55 +0000 (GMT)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        terje.eggestad@scali.com (Terje Eggestad),
        greearb@candelatech.com (Ben Greear),
        davidel@xmailserver.org (Davide Libenzi),
        george@mvista.com (george anzinger)
In-Reply-To: <Pine.LNX.3.95.1020308134552.6627A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 08, 2002 01:54:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jPuG-0007Cz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following program clearly shows that Linux will not return the
> same gettimeofday values twice in succession. Since it provably takes
> less than 1 microsecond to make a system call on a modern machine,

We don't wait. Your computer just sucks 8)

More seriously even on a processor with a TSC we have to take a lock and
do several computations.

Alan
