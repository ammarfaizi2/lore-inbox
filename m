Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDYIHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 04:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTDYIHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 04:07:31 -0400
Received: from quechua.inka.de ([193.197.184.2]:8642 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261743AbTDYIHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 04:07:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <20030424212811.GH30082@mail.jlokier.co.uk>
References: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com> <20030424212811.GH30082@mail.jlokier.co.uk>
Date: Fri, 25 Apr 2003 10:13:58 +0200
Message-Id: <20030425081358.B750C2128A@dungeon.inka.de>
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, the game server and the BIOS have a chat, through the operating
> system (which counts as an insecure link), and the BIOS tells the
> server that it is the correct DRM BIOS, and it loaded a signed kernel.

[lots of additional chats]

that does not work: the server could chat with a bios in a vmware
unaware of that fact.

but tcpa is a solution to that problem. first it doesn't need 
all those chats but only one where a list of hash value with
a signature is transmitted. the hash values represent the software
packages (such as bios, boot loader, kernel, drivers, ...)
and the signature proofs its authentity.

second the signature proofs the non virtualization:
a key and certificate is required to do that, and the
cert is checked if it has a chain to one root and it
is not revoked. such certificates are only created
by trusted hardware manufacturers and they certify
only real hardware with the private key in a TPM module
that cannot export the key.

however, if someone opens a TPM module and reads the
content physicaly, then the trust is gone (at least
till someone finds out and that key is revoked).
IBM claims their TPM module containt no hardware security
(like that stuff usualy found in smartcards).

> Substitute "broadcaster" for "game server" and you see that the same
> methods ensure that you really have the TV switched on and you are not
> recording the show.

absolutely correct.

But I'd like a small usb device that is like "broadcaster" or "game
server" and tells me when plugged into any machine "this is secure,
no trojans/backdoors/key sniffing software installed". But that might
be even harder to do?

> They also ensure you are not recording a screenshot of a politically
> sensitive article about Iraq that was accidentally shown on CNN's web
> site for 10 minutes.  We can't have people recording things like that.

Hey, good we still have normal photos.  and usualy you can "print"
things on webpages.


> Also that day, that same article doesn't load from Al-Jazeera or
> anywhere else, on the PC you bought from the only affordable store in
> town. 

ah, myth. please dig into the tcpa spec and quote where you find
anything that provides substance for that. possible? even today without
tcpa or DRM or anything like that. but why does DRM or TCPA make this
easier or harder to work around?

if we could asure that DRM would only be used in 0.1% of all computer
uses, then banks and stuff could use it, maybe even that digitial video
rental using the internet (they already do, but without hardware
support), and everyone else will not. I don't see the problem with
some uses, but with everyone using it.

Andreas
