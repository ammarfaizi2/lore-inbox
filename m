Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290574AbSBFOcZ>; Wed, 6 Feb 2002 09:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290578AbSBFOcP>; Wed, 6 Feb 2002 09:32:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49160 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290574AbSBFOcF>; Wed, 6 Feb 2002 09:32:05 -0500
Subject: Re: kernel: ldt allocation failed
To: ak@suse.de (Andi Kleen)
Date: Wed, 6 Feb 2002 14:39:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020206150949.A10871@wotan.suse.de> from "Andi Kleen" at Feb 06, 2002 03:09:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YTEi-0005KG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure it does? LGDT with non zero argument shouldn't be that costly. 
> The %fs switching adds some locked cycles for reloading the segment cache, 
> but because Windows uses that I would it expect to be reasonably optimized 
> on CPUs. 

Its measurable, even on an Athlon. 

> I actually tried to complain because on x86-64 it is more costly, but to
> no avail. 

The more I see from glibc the more I realise that Linus is right - it needs
replacing 

