Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbRETTr6>; Sun, 20 May 2001 15:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262192AbRETTrs>; Sun, 20 May 2001 15:47:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16906 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262190AbRETTrg>; Sun, 20 May 2001 15:47:36 -0400
Subject: Re: [PATCH] 2.4.4-ac11 network drivers cleaning
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 20 May 2001 20:43:39 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens),
        ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <3B072A49.B44B0F2A@mandrakesoft.com> from "Jeff Garzik" at May 19, 2001 10:22:01 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151Z75-0002mo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         printk("%s\n", version);
> > 
> > Not quite as optimal but safer.
> 
> I disagree.   Don't work around an escape bug in a version string, fix
> it...

A % in a version string might be quite reasonable. You are asking to have
an accident by avoiding it. If you want to fight over 4 bytes, then add
a single constant "%s\n", and #define putk() from it


