Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSF2CBg>; Fri, 28 Jun 2002 22:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSF2CBf>; Fri, 28 Jun 2002 22:01:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62993 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317182AbSF2CBe>; Fri, 28 Jun 2002 22:01:34 -0400
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
To: ink@jurassic.park.msu.ru (Ivan Kokshaysky)
Date: Sat, 29 Jun 2002 03:26:18 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
       alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020628145406.A17560@jurassic.park.msu.ru> from "Ivan Kokshaysky" at Jun 28, 2002 02:54:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17O7wJ-0007vj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC, the problem is that BSD and OSF readv/writev(2) manuals
> explicitly talked of 32 bit iov_len, thus allowing the application
> to pass junk in an upper half of the 64 bit word.
> This change broke widely used netscape and acrobat reader,
> please revert it until we have a better solution:

Please fix the Alpha port. The behaviour fixed is _required_ by SuS.
Make your own alpha syscall that handles this crap.
