Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278263AbRJWUsg>; Tue, 23 Oct 2001 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRJWUs1>; Tue, 23 Oct 2001 16:48:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35334 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278263AbRJWUsR>; Tue, 23 Oct 2001 16:48:17 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 23 Oct 2001 21:54:23 +0100 (BST)
Cc: jlundell@pobox.com (Jonathan Lundell), alan@lxorguk.ukuu.org.uk (Alan Cox),
        mochel@osdl.org (Patrick Mochel), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20011023202258.5598@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at Oct 23, 2001 10:22:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w8Z6-00010E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >"Stop accepting new requests" is nontrivial as well, in the general 
> >case. New requests that can't be discarded need to be queued 
> >somewhere. Whose responsibility is that? Ideally at some point where 
> >a queue already exists, possibly in the requester.
> 
> Some driver already handle queues. In the case of network driver, just
> stop your network queue and stop accepting incoming packets. If your
> driver is too simple to have queues, a simple semaphore on entry points
> can often be enough. You shouldn't deadlock as you are not supposed to
> re-enter a sleeping driver in step 2.

Stop accepting new requests is not simple. To complete existing requests you
might need an arbitary other module to complete a new request you submit
as part of your shutdown. 

Alan
