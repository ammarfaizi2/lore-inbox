Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTBCWen>; Mon, 3 Feb 2003 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBCWen>; Mon, 3 Feb 2003 17:34:43 -0500
Received: from mailb.telia.com ([194.22.194.6]:49608 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S267024AbTBCWel>;
	Mon, 3 Feb 2003 17:34:41 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <007201c2cbd5$bec836a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Ion Badulescu" <ionut@badula.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302031725090.27869-100000@guppy.limebrokerage.com>
Subject: Re: NETIF_F_SG question
Date: Mon, 3 Feb 2003 23:44:00 +0100
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

> On Mon, 3 Feb 2003, Joakim Tjernlund wrote:
> 
> > > You get zerocopy, yes. :-) No HW cksum, no zerocopy.
> > 
> > OK, but it should be easy to remove HW cksum as a condition to do zerocopy?
> 
> Nope. You're looking at this the wrong way: the goal is not zero copy, but 
> zero data access by CPU. Once you realize that, it's clear that SG alone 
> is no good.
> 
> This is not necessarily the only approach, but it is the current approach 
> in the Linux IPv4 stack. It's not worth the effort to re-engineer the code 
> in order to support the fast-disappearing hardware which supports SG but 
> not cksums.

Agreed.
> 
> > zerocopy without requiring HW cksums only OR could for instance the forwarding
> > procdure also benefit from SG without  requiring HW cksums?
> 
> The forwarding procedure is already dealing with linear buffers because 
> 99.99% of the network cards on the market receive packets into one linear 
> buffer. So again SG is useless for that.

I see, thanks for your patience with me.

  Joakim
> 
> Ion

