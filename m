Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbSIXVbY>; Tue, 24 Sep 2002 17:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbSIXVa0>; Tue, 24 Sep 2002 17:30:26 -0400
Received: from [202.54.24.132] ([202.54.24.132]:47546 "EHLO
	dns2.ggn.hcltech.com") by vger.kernel.org with ESMTP
	id <S261820AbSIXVaR>; Tue, 24 Sep 2002 17:30:17 -0400
Message-ID: <5F0021EEA434D511BE7300D0B7B6AB53050A4C9D@mail2.ggn.hcltech.com>
From: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Interrupt Sharing
Date: Wed, 25 Sep 2002 03:10:07 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But what if two PCI Devices are sharing the same interrupt line?
Then how does the handler handle this?
Can you please explain this handling by the Kernel?

-MG

> -----Original Message-----
> From: Robert Love [mailto:rml@tech9.net]
> Sent: Wednesday, September 25, 2002 2:55 AM
> To: Mohamed "Ghouse , Gurgaon
> Cc: Linux-Kernel (E-mail)
> Subject: Re: Interrupt Sharing
> 
> 
> On Tue, 2002-09-24 at 17:19, Mohamed Ghouse , Gurgaon wrote:
> 
> > Let me Re-Phrase the Question
> > The PCI Interrupts are shareable. How does the Operating 
> System(Linux)
> > implement this?
> 
> It does not have to do anything special, actually.  If 
> interrupt n comes
> in, then each handler registered on interrupt n is run.
> 
> The incorrect handlers should check for work to do, see none, and
> return.  The correct one will actually run.
> 
> 	Robert Love
> 
