Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313779AbSDPRja>; Tue, 16 Apr 2002 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313780AbSDPRj3>; Tue, 16 Apr 2002 13:39:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59142 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313779AbSDPRj3>; Tue, 16 Apr 2002 13:39:29 -0400
Subject: Re: OK, who broke the serial driver in 2.4.19-pre7?
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 16 Apr 2002 18:57:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br (Marcelo Tosatti),
        khalid_aziz@hp.com
In-Reply-To: <200204161712.g3GHCw513349@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Apr 16, 2002 11:12:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xXCg-0000T7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Hi, all. 2.4.19-pre7 has broken the serial driver. With 2.4.19-pre6
> and before, my first serial port was ttyS0 (4, 64), and I got these
> kernel messages:
> Was this broken by the HCDP serial ports changes?

Yes. Someone put the HCDP below not above the basic x86 ports. Tweak
include/asm-i386/serial.h and that should be well. 

Alan

