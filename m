Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289653AbSBJOnv>; Sun, 10 Feb 2002 09:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289655AbSBJOnk>; Sun, 10 Feb 2002 09:43:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289653AbSBJOnY>; Sun, 10 Feb 2002 09:43:24 -0500
Subject: Re: APM fix from -pre7 seems to break "Dell laptop support"
To: glouis@dynamicro.on.ca
Date: Sun, 10 Feb 2002 14:56:59 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (LKML), dz@debian.org
In-Reply-To: <20020210130447.GA1001@athame.dynamicro.on.ca> from "Greg Louis" at Feb 10, 2002 08:04:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZvPX-0003hD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With CONFIG_I8K=y and Massimo Dal Zotto's i8k utilities, it's necessary
> for me to revert Stephen Rothwell's 2.4.17-APM.1 patch that went into
> 18-pre7.  If I don't, CPU temperature readings jump around erratically
> and the fans come on at the wrong temperatures.  I reported this to
> Stephen and on lkml at the time -pre7 came out, but the problem is
> still there in -pre9.  If the patch offers real benefits to non-Dell
> folk I guess I can just continue reverting...

CONFIG_I8K gives you direct control of the hardware features on the machine
while APM itself is also responsible for managing them. That there is a food
fight as a result should not be a suprise.

What you may want to try is using a semaphore so you never issue an APM
and an I8K call/request at the same time
