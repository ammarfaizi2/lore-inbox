Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279570AbRJXNT3>; Wed, 24 Oct 2001 09:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279565AbRJXNTT>; Wed, 24 Oct 2001 09:19:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33542 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279567AbRJXNS6>; Wed, 24 Oct 2001 09:18:58 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Oct 2001 14:25:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com> from "Benjamin Herrenschmidt" at Oct 24, 2001 03:04:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wO1x-0001Vt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, I'm not sure what would happen with RAID. If we need to have logical
> volumes be child of the sd "client", then we have to face the fact that
> a given child may have multiple parents... welcome to the power graph !
> But do we really need logical volumes to be part of the PM tree or
> can blocking of requests at the sd layer be enough ? Remember we are
> in pass2, we have already done memory allocation, we are supposed to
> no longer swap nor do any disk/storage related activity.

Assuming you want to synchronize the raid before suspend - a reasonably
policy but not essential then you'd have to shut down the raid before
sd, then sd would let the devices shut down which lets the controller
shutdown
