Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291463AbSBHIa4>; Fri, 8 Feb 2002 03:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291472AbSBHIaq>; Fri, 8 Feb 2002 03:30:46 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:42510 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S291463AbSBHIaf>;
	Fri, 8 Feb 2002 03:30:35 -0500
Date: Fri, 8 Feb 2002 08:35:29 +0000
From: Ian Molton <spyro@armlinux.org>
To: root@chaos.analogic.com
Cc: joe.perches@spirentcom.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
Message-Id: <20020208083529.65befc73.spyro@armlinux.org>
In-Reply-To: <Pine.LNX.3.95.1020207125644.8721A-100000@chaos.analogic.com>
In-Reply-To: <9384475DFC05D2118F9C00805F6F263107ECA811@exchange1.netcomsystems.com>
	<Pine.LNX.3.95.1020207125644.8721A-100000@chaos.analogic.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a sunny Thu, 7 Feb 2002 13:08:24 -0500 (EST) Richard B. Johnson gathered
a sheaf of electrons and etched in their motions the following immortal
words:

> On Thu, 7 Feb 2002, Perches, Joe wrote:
> [SNIPPED..]
> > > That is correct UDP behaviour 
> > 
> > Do you think this is the correct PacketSocket/RAW behaviour?
> 
> Yes.
> 
> > How does one guarantee a send/sendto/write?
> > -
> 
> Easy, you use send() or write(). These work on stream protocol TCP/IP

I know its an extreme case, but consider that something goes wrong and the
kernel ends up thinking its buffer is always full / zero lenngth /
something horrible.

I'd personally like it if it warned me it wasnt even trying to send my
packets, rather than just ignoring them completely...
