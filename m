Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273724AbRI3QPe>; Sun, 30 Sep 2001 12:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273739AbRI3QPY>; Sun, 30 Sep 2001 12:15:24 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:46860 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S273724AbRI3QPO>; Sun, 30 Sep 2001 12:15:14 -0400
Message-Id: <200109301615.f8UGFUY62492@aslan.scsiguy.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Ookhoi <ookhoi@dds.nl>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) (solved) 
In-Reply-To: Your message of "Sun, 30 Sep 2001 00:03:27 PDT."
             <20010930000327.F2665@one-eyed-alien.net> 
Date: Sun, 30 Sep 2001 10:15:30 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hrm... this makes me wonder if the Byte Merge option is keeping the PCI
>consistancy rules, or perhaps the aic7xxx driver is making assumptions
>about when PCI writes are actually occuring, without doing a read cycle
>between critical writes to make sure they actually happen.

See my other post on this subject.  The driver knows that a read is
required to ensure that a write is posted, but assumes that 8bit
transactions are forwarded as such, writes are issued in the order
retired (we use a memory barrier to avoid the compiler using a
different order), and that reads cannot pass posted writes.

--
Justin
