Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311859AbSCNXOc>; Thu, 14 Mar 2002 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311861AbSCNXOW>; Thu, 14 Mar 2002 18:14:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41221 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311859AbSCNXOL>; Thu, 14 Mar 2002 18:14:11 -0500
Subject: Re: IO delay, port 0x80, and BIOS POST codes
To: kerndev@sc-software.com (John Heil)
Date: Thu, 14 Mar 2002 23:29:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203141437450.1286-100000@scsoftware.sc-software.com> from "John Heil" at Mar 14, 2002 02:39:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lefJ-0002EK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We've got one. Its 0x80. It works everywhere with only marginal non
> > problematic side effects
> >
> 
> Ok, cool but does that mean you agree or disagree with a configurable
> override for those of us in the minority?

If we put every single requested obscure fix for one or two boxes into
the kernel configuration you'd be spending weeks wading through

"Handle weird APM on Dave's homebrew mediagx"

and other questions.

Let me suggest something else. For any kernel built with TSC assumed
(586TSC +) initialize the udelay loop to something guaranteed to be at
least too long for any conceivable processor and use udelay() for the I/O
delay timing.

Alan
