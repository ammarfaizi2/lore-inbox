Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287994AbSAHM1W>; Tue, 8 Jan 2002 07:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287995AbSAHM1N>; Tue, 8 Jan 2002 07:27:13 -0500
Received: from weta.f00f.org ([203.167.249.89]:62661 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S287994AbSAHM1C>;
	Tue, 8 Jan 2002 07:27:02 -0500
Date: Wed, 9 Jan 2002 01:30:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
Message-ID: <20020108123005.GA29924@weta.f00f.org>
In-Reply-To: <E3B8D7A16F6@vcnet.vc.cvut.cz> <Pine.GSO.3.96.1020108130224.28906B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020108130224.28906B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 01:12:04PM +0100, Maciej W. Rozycki wrote:

    A possible reason is the 8259A in the chipset deasserts its INT
    output late enough for the Athlon CPU's local APIC to register
    another ExtINTA interrupt sometimes, possibly under specific
    circumstances.

Actully... we could potentially measure this... after an interrupt it
serviced (or before, or both) we could store the interrupt source
globally and the cycle counter... when a suprrious interrupt is
received check the last interrupt and how long ago it was and then
start looking for a pattern...



  --cw
