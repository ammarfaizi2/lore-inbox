Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSEFPmh>; Mon, 6 May 2002 11:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314544AbSEFPmg>; Mon, 6 May 2002 11:42:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14084 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314529AbSEFPmf>; Mon, 6 May 2002 11:42:35 -0400
Subject: Re: 2.5.13 IDE and preemptible kernel problems
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 6 May 2002 17:01:02 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki), ak@muc.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205041903480.1594-100000@home.transmeta.com> from "Linus Torvalds" at May 04, 2002 07:09:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E174kv8-0005cV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > immediately that there is a need for single argument
> > time_past() or whatever and I turn spinlock debugging on :-).
> 
> Hmm.. Something like
> 	#define timeout_expired(x)	time_after(jiffies, (x))
> 
> migth indeed make sense.

That would be good because in the longer term the elimination of random
references to jiffies is pretty essential to low power devices and for 
things like S/390 scaling.

Alan
