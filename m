Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbRG0Nc0>; Fri, 27 Jul 2001 09:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268852AbRG0NcR>; Fri, 27 Jul 2001 09:32:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9735 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268848AbRG0NcJ>; Fri, 27 Jul 2001 09:32:09 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 27 Jul 2001 14:27:40 +0100 (BST)
Cc: bvermeul@devel.blackstar.nl, J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw),
        haiquy@yahoo.com (Steve Kieu),
        samuelt@cervantes.dabney.caltech.edu (Sam Thompson),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "Hans Reiser" at Jul 27, 2001 04:55:51 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q7eW-0005cP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > and when that hangs the kernel it will also screw up all files touched
> > just before it in a edit-make-install-try cycle. Which can be rather
> > annoying, because you can start all over again (this effect randomly
> > distributes the last touched sectors to the last touched files. Very nice
> > effect, but not something I expect from a journalled filesystem).
> > 
> Do you think it is reasonable to ask that a filesystem be designed to
> work well with bad drivers?

Its certainly a good idea. But it sounds to me like he is describing the
normal effect of metadata only logging. 

Putting a sync just before the insmod when developing new drivers is a good
idea btw

