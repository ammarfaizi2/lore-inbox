Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264738AbRFQO6y>; Sun, 17 Jun 2001 10:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbRFQO6o>; Sun, 17 Jun 2001 10:58:44 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:26891 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264738AbRFQO6b>; Sun, 17 Jun 2001 10:58:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: rjd@xyzzy.clara.co.uk, phillips@bonn-fries.net (Daniel Phillips)
Subject: Re: Newbie idiotic questions.
Date: Sun, 17 Jun 2001 17:01:10 +0200
X-Mailer: KMail [version 1.2]
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        bpringle@sympatico.ca (Bill Pringlemeir), linux-kernel@vger.kernel.org
In-Reply-To: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk>
In-Reply-To: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk>
MIME-Version: 1.0
Message-Id: <0106171701100P.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 June 2001 14:27, rjd@xyzzy.clara.co.uk wrote:
> Daniel Phillips wrote:
> > > because then you would be allocating the size of a pointer, not the
> > > size of a structure
> >
> > Whoops Jeff, you didn't have your coffee yet:
>
> Whoops yourself. The following patch brings your example into line with
> the driver code. mpuout is a pointer to a structure not the structure
> itself as the malloc assignment clearly indicates.

Yep, the only thing left to resolve is whether Jeff had coffee or not. ;-)

-	if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))
+	if ((card->mpuout = kmalloc(sizeof(*card->mpuout), GFP_KERNEL))

--
Daniel
