Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSLSQNT>; Thu, 19 Dec 2002 11:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLSQNT>; Thu, 19 Dec 2002 11:13:19 -0500
Received: from mail7.home.nl ([213.51.128.24]:24830 "EHLO mail7-sh.home.nl")
	by vger.kernel.org with ESMTP id <S262326AbSLSQNS>;
	Thu, 19 Dec 2002 11:13:18 -0500
From: Frank van de Pol <fvdpol@home.nl>
Date: Thu, 19 Dec 2002 17:24:00 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frank van de Pol <fvdpol@home.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52: PDC20268 failure - ACPI to blame !!!
Message-ID: <20021219162400.GC1196@idefix.fvdpol.home.nl>
References: <20021218232901.GA20290@idefix.fvdpol.home.nl> <1040259796.26906.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040259796.26906.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-pre2 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 01:03:16AM +0000, Alan Cox wrote:
> On Wed, 2002-12-18 at 23:28, Frank van de Pol wrote:
> > 
> > the 2.5 series of kernels (since early ide changes) fails on my machine when
> > configuring the harddisks.
> 
> Can you tell me if 2.4.21-pre does - that has the IDE changes without
> the other stuff so is a good test of which bit is involved
> 
> Also try 2.5.52 with ACPI disabled

Good thinking Alan! it seems ACPI is causing the trouble.

2.4.18 - OK
2.4.19 - OK
2.4.20 - OK
2.4.21-pre2 OK  (using pdc202xx_new driver)

2.5.52 with ACPI - Failure, IRQ troubles wrong IRQ assigned for promise
                   boards, lockup of box during boot
2.5.52 no ACPI   - OK !!!

What information do I need to provide to fix this problem?

Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?
