Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263443AbREXX1r>; Thu, 24 May 2001 19:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263447AbREXX1h>; Thu, 24 May 2001 19:27:37 -0400
Received: from www.microgate.com ([216.30.46.105]:14610 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S263443AbREXX10>; Thu, 24 May 2001 19:27:26 -0400
Message-ID: <008801c0e4a9$1de867b0$0201a8c0@mojo>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E1533Ra-0005hC-00@the-village.bc.nu>
Subject: Re: SyncPPP Generic PPP merge
Date: Thu, 24 May 2001 18:27:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> I suspect that bit can be fixed if need be. Its nice to keep a constant
> naming between cisco/ppp modes. cisco/ppp autodetect is also possible and
would
> be rather nice to support

I can't see getting around moving the net device allocation out of each
low level driver and into the layer above it. That removes
duplicate code and allows syncppp to do the right thing (allocate it itself
for cisco or allow ppp_generic.c do it for PPP). This would make
net device naming consistancy easier.

The low level drivers should not need any awareness of the net device
(possibly other than suggesting a name) as all they do is send and
receive frames.

The rest of the syncppp API should be (re)usable.

> Assuming this is a 'when 2.5 starts' discussion I'd like initially to keep
the
> syncppp api is but the pppd code going via generic ppp - and yes it would
> break configs.
>
> Clearly thats not 2.4 acceptable

Agreed, but it's a good time to call the cats to the herding pen.

Paul Fulghum paulkf@microgate.com
Microgate Corporation http://www.microgate.com


