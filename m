Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287756AbSANRLw>; Mon, 14 Jan 2002 12:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSANRLm>; Mon, 14 Jan 2002 12:11:42 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:20488 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S287734AbSANRLd>; Mon, 14 Jan 2002 12:11:33 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: ISA hardware discovery -- the elegant solution
Date: 14 Jan 2002 18:11:30 +0100
Organization: Cistron Internet Services
Message-ID: <a1v3g2$h8s$1@picard.cistron.nl>
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se> <20020114111141.A14332@thyrsus.com> <3C430E89.E65DCEDC@inet.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C430E89.E65DCEDC@inet.com>,
Eli Carter  <eli.carter@inet.com> wrote:
>Could you maybe describe the problem you are trying to solve a bit more
>clearly than "the hardware-discovery problem for ISA devices"?  If you
>are trying to discover the ISA devices, but rely upon them having
>already been discovered, what are you accomplishing?

The problem is that it is simply not possible to identify ISA devices
if they aren't isapnp devices. The only thing you can do is try to
probe for them by poking at different addresses and checking what happens.
Unfortunately this can do any of three things: show that a piece of
hardware exists, show that it is not there or completely crash your
machine if another unpexpected piece of hardware happens to be at the 
place you are poking.

The best approach to doing ISA detection is ask the user which
devices he thinks he has installed and try looking for them while
praying bad things won't happen.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

