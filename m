Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTBCWNW>; Mon, 3 Feb 2003 17:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBCWNW>; Mon, 3 Feb 2003 17:13:22 -0500
Received: from maila.telia.com ([194.22.194.231]:19429 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S265754AbTBCWNU>;
	Mon, 3 Feb 2003 17:13:20 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <006a01c2cbd2$bff0b870$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Ion Badulescu" <ionut@badula.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
References: <200302032118.h13LIfqN006832@buggy.badula.org>
Subject: Re: NETIF_F_SG question
Date: Mon, 3 Feb 2003 23:22:34 +0100
Organization: Lumentis AB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2 Feb 2003 02:39:41 +0100, Joakim Tjernlund <Joakim.Tjernlund@lumentis.se> wrote:
> > 
> > I think HW checksumming and SG are independent. Either one of them should
> > not require the other one in any context.
> 
> They should be independent in general, but they aren't when the particular
> case of TCP/IPv4 is concerned.
> 
> > Zero copy sendfile() does not require HW checksum to do zero copy, right?
> 
> Wrong...
> 
> > If HW checksum is present, then you get some extra performance as a bonus.
> 
> You get zerocopy, yes. :-) No HW cksum, no zerocopy.

OK, but it should be easy to remove HW cksum as a condition to do zerocopy?

> 
> Don't let this stop you, however. It's always possible that other networking
> stacks will eventually make use of SG while not requiring HW TCP/UDP cksums.
> None of them do right now, but...

zerocopy without requiring HW cksums only OR could for instance the forwarding
procdure also benefit from SG without  requiring HW cksums?

> 
> > (hmm, one could make SG mandatory and the devices that don't support it can 
> > implement it in their driver. Just an idea)
> 
> Not really, that way lies driver madness. The less complexity in the driver,
> the better.

Just a wild idea, forget it. You are right
   
         Joakim
> 
> Ion
> [starfire driver maintainer]
