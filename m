Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRHGUcA>; Tue, 7 Aug 2001 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRHGUbu>; Tue, 7 Aug 2001 16:31:50 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:22477 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S269223AbRHGUbg>; Tue, 7 Aug 2001 16:31:36 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200108072030.VAA30471@mauve.demon.co.uk>
Subject: Re: Encrypted Swap
To: linux-kernel@vger.kernel.org (l)
Date: Tue, 7 Aug 2001 21:30:56 +0100 (BST)
In-Reply-To: <Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net> from "Justin Guyett" at Aug 06, 2001 08:56:15 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 7 Aug 2001, David Spreen wrote:
> 
> > I was just searching for swap-encryption-solutions in the lkml-archive.
> > Did I get the point saying ther's no way to do swap encryption
> > in linux right now? (Well, a swapfile in an encrypted kerneli
> > partition r something like that is not really what I want to
> > do I think).
> 
> What's the benefit?  Sure, attackers have to know that encrypted swap is
> in use, and have to be able to find the key in memory, but they already
> can do both if they're root, and non-root can't [shouldn't be able to]
> read swap devices on a properly secured machine.  Swap isn't meant for

Consider a laptop.
It normally mounts data and swap encrypted.
it requires a passphrase to login to a user which has access to
the encrypted filesystem.

When the laptop is closed, or on an inactivity timeout, it halts normal
processing, encrypts all RAM, and then invokes the "save to disk" mechanism.

Data can only be stolen if the operator cannot shut the laptop, 
and the attacker does not do so, or if the operator can be coerced
to reveal the key.

What would be even nicer would be a way to checkpoint in a secure
manner all processes tainted by accessing a secure device.

