Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263449AbRFRE2Z>; Mon, 18 Jun 2001 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbRFRE2P>; Mon, 18 Jun 2001 00:28:15 -0400
Received: from axon.amtp.cam.ac.uk ([131.111.16.133]:33198 "EHLO
	axon.amtp.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S263449AbRFRE2B>; Mon, 18 Jun 2001 00:28:01 -0400
Date: Mon, 18 Jun 2001 05:27:58 +0100 (BST)
From: J.S.Peatfield@damtp.cam.ac.uk
Message-Id: <200106180427.FAA20673.declaim.amtp.cam.ac.uk@damtp.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: EEPRO100/S support
Cc: J.S.Peatfield@damtp.cam.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, I believe Intel's Linux drivers will support this card under
> 2.4, and I believe (not 100% certain on this) that they're GPL.  I'll
> have to check on that.

The e100 driver from intel claims to support these cards (the 100 S
desktop adaptor, that is), but in fact the drivers lock up under heavy
UDP load (at least they do for me in 2.2.19).  It seems to only be a
problem with these newer cards, the e100 is solid with older cards
(and things like the 100VE which is onboard on many Easterns).

Intel are working on fixing the lockups, they thought it was related
to the checksum offload though turning that off doesn't prevent the
lockups.  Version 1.66 is much more stable than 1.55a (1.55a would
lockup after 60-80M of traffic on these cards), I'm awaiting the next
version to see if they have nailed it.

The driver is not GPL (I don't know why it isn't) and doesn't support
the encryption asic on baords which have it (and Intel seem unwilling
to release details of this asic so others can write drivers to use
it).

I've no idea if the e100 works on anything other than ia32/ia64.
