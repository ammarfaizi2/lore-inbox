Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSAFT1j>; Sun, 6 Jan 2002 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289011AbSAFT13>; Sun, 6 Jan 2002 14:27:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37125 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289010AbSAFT1U>; Sun, 6 Jan 2002 14:27:20 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: znmeb@aracnet.com ("M. Edward (Ed) Borasky")
Date: Sun, 6 Jan 2002 19:38:08 +0000 (GMT)
Cc: vda@port.imtp.ilyichevsk.odessa.ua (vda@port.imtp.ilyichevsk.odessa.ua),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201061101370.5442-100000@shell1.aracnet.com> from "M. Edward (Ed) Borasky" at Jan 06, 2002 11:16:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NJ7R-0006Iq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> That would do it, but I was trying to give a real-world example from
> image processing, like copying a large image file.

Image processing people use tiling. Try loading a giant image into
the gimp and into a non smart application like xpaint. The difference is
huge just by careful implementation of the algorithms

> Then the second pass will do an FFT on every column (row). The stride is
> 16384*16 = 262144 bytes. This is a new page for each 16-byte complex
> value you process :-). That is, all 16384 pages have to be in memory, or
> swapped into memory if you've run out of real memory and the kernel has
> swapped them out.

Yes but you don't do it that way, you do stripes of parallel fft
computations. We can all write dumb programs that don't behave well with the
VM layer.

Alan
