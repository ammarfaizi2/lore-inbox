Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131043AbRAPMFc>; Tue, 16 Jan 2001 07:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbRAPMFK>; Tue, 16 Jan 2001 07:05:10 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:33034 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131017AbRAPMFA>; Tue, 16 Jan 2001 07:05:00 -0500
Date: Tue, 16 Jan 2001 06:04:49 -0600
To: "Herrmann, Achim" <AHerrmann@heiler.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: modules, insmod and multiple object files
Message-ID: <20010116060449.B12650@cadcamlab.org>
In-Reply-To: <C113A60DF3FFD3118B9A00508BA8F54205DC88@hskomm02.heiler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <C113A60DF3FFD3118B9A00508BA8F54205DC88@hskomm02.heiler.com>; from AHerrmann@heiler.com on Tue, Jan 16, 2001 at 12:56:33PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Achim Herrmann]
> main.o was created using language "C": gcc -c main.c -o main.o
> and 
> hwaccess.o was created using assembler: nasm -f elf hwaccess.asm -o
> hwaccess.o
> 
> Is there a possibility to combine these two object files, so that I
> have a module which is loadable by insmod?

I'm not very familiar with 'nasm', but assuming it produces regular elf
object files:

  $(LD) -r -o {target}.o main.o hwaccess.o

'$(LD) -r' is used lots of places in kernel makefiles already.  (Too
many places, actually, most of which could and should be automated.
Kai Germaschewski has recently done some work to this end.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
