Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLMHSl>; Wed, 13 Dec 2000 02:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLMHSa>; Wed, 13 Dec 2000 02:18:30 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36101
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129289AbQLMHSM>; Wed, 13 Dec 2000 02:18:12 -0500
Date: Tue, 12 Dec 2000 22:47:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: alex@foogod.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] I-Opener fix (again)
In-Reply-To: <20001211152331.M10618@draco.foogod.com>
Message-ID: <Pine.LNX.4.10.10012122217440.4894-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Basically if the setting of 

 * "hdx=flash"          : allows for more than one ata_flash disk to be
 *                              registered. In most cases, only one device
 *                              will be present.

fails then I will look into this but, the breaking of laptops that have
CFA devices that do not come on channels in a pair canb not happen.
If you have a vender unique setting that will follow always the way
I-Opener's are setup then that is better.

Cheers,

On Mon, 11 Dec 2000 alex@foogod.com wrote:

> It's been a few months (and a couple of kernel releases) since I mentioned this
> before and it doesn't look like it's made it in, and I haven't seen any more
> comments on it in the list archives, so I'm bringing it up again in case it
> just got forgotten about somewhere along the line..
> 
> As I remember, Andre Hedrick had asked for clarification on my original post,
> and I sent a followup message in response, but now I can't seem to find it
> anywhere in the archives, so I don't know whether it never made it out of my
> mailer or..
> 
> In any case, attached is a patch (against 2.4.0pre11) which fixes the bug which
> causes disk detection issues on I-Opener (and possibly other unusual) hardware.
> 
> The problem is that the code assumes that a flash-disk will always be the
> primary disk on an interface, but on the I-Opener this is not always the case.
> If a traditional disk is primary, and a flashdisk is secondary, the detection
> code (wrongly) disables the primary disk that it had already previously
> detected.
> 
> I would like to see this make it into the official source as it's a very small
> change that fixes some obviously wrong behavior..
> 
> -alex
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
