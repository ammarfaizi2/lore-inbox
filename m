Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293661AbSCEXwF>; Tue, 5 Mar 2002 18:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293656AbSCEXvq>; Tue, 5 Mar 2002 18:51:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22282 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293652AbSCEXvd>; Tue, 5 Mar 2002 18:51:33 -0500
Subject: Re: FPU precision & signal handlers (bug?)
To: paubert@iram.es (Gabriel Paubert)
Date: Wed, 6 Mar 2002 00:06:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203051919280.7951-100000@gra-lx1.iram.es> from "Gabriel Paubert" at Mar 05, 2002 07:23:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iOx5-0004oK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Think about MMX and hopefully it makes sense then.
> 
> AFAIR MMX only mucks with tag and status words (and the exponent fields of
> the stack elements), but never depends on or modifies the control word.

Right but you don't want to end up in MMX mode by suprise in a
signal handler in library code. By the same argument you don't want to end
up in a weird maths more.

I don't think its a bug. I think its correct (but seriously underdocumented)
behaviour
