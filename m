Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132032AbRC1RBm>; Wed, 28 Mar 2001 12:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132034AbRC1RBc>; Wed, 28 Mar 2001 12:01:32 -0500
Received: from gopostal.digi.com ([204.221.110.15]:61959 "EHLO gopostal.digi.com") by vger.kernel.org with ESMTP id <S132032AbRC1RBU>; Wed, 28 Mar 2001 12:01:20 -0500
From: Jeff Randall <randall@bif.digi.com>
Message-Id: <200103281659.KAA29060@bif.digi.com>
Subject: Re: Larger dev_t
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 28 Mar 2001 10:59:09 -0600 (CST)
Cc: hpa@transmeta.com (H. Peter Anvin), alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com (Linus Torvalds), Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <20010327234308.B5411@flint.arm.linux.org.uk> from "Russell King" at Mar 27, 2001 11:43:08 PM
Reply-To: Jeff_Randall@digi.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I for one would like to see a major number for all 'serial ports' whether
> they be embedded ARM serial ports _or_ standard 16550 ports, but at the
> moment its not easily acheivable without introducing more mess.
> 
> Ted indicated to me a while ago (just after I wrote serial_core.c for
> yet-another-type-of-ARM-serial-port) his visions of the direction serial
> stuff should take in 2.5; this is obviously one of the things that I'm
> keen to discuss and solve in 2.5.

A change to a 12:20 major:minor dev_t would be a great help for the various
serial drivers that I write and help maintain.  We currently as a company
maintain 4 different serial device drivers for linux and all of them
currently use between 4 and 10 majors in order to have enough raw minors
available to identify the maximum port count supported.  We had to do the
same think on SunOS (which also has 8:8) in order to support reasonable port
counts there.  I'd absoultely love the ability to get back on a single major
per driver.

I'd like to see all of the serial drivers shipped in the kernel tree be
configured by default to use the same major.. but I wouldn't want to have
external drivers forced onto that major as well.

-- 
Jeff Randall - Jeff_Randall@digi.com  "A paranoid person is never alone,
                                       he knows he's always the center
                                       of attention..."
