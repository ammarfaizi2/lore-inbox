Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSCOLgn>; Fri, 15 Mar 2002 06:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291258AbSCOLgd>; Fri, 15 Mar 2002 06:36:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46121 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S291081AbSCOLgZ>; Fri, 15 Mar 2002 06:36:25 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Heil <kerndev@sc-software.com>, <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.4.33.0203141318130.9855-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Mar 2002 04:30:44 -0700
In-Reply-To: <Pine.LNX.4.33.0203141318130.9855-100000@penguin.transmeta.com>
Message-ID: <m1u1rixe3f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Thu, 14 Mar 2002, John Heil wrote:
> > 
> > No, the better/correct port is 0xED which removes the conflict.
> 
> Port ED is fine for a BIOS, which (by definition) knows what the
> motherboard devices are, and thus knows that ED cannot be used by
> anything.
> 
> But it _is_ an unused port, and that's exactly the kind of thing that
> might be used sometime in the future. Remember the port 22/23 brouhaha
> with Cyrix using it for their stuff, and later Intel getting into the fray
> too?
> 
> So the fact that ED works doesn't mean that _stays_ working.
> 
> The fact that 80 is the post code register means that it is fairly likely 
> to _stay_ that way, without any ugly surprises.
> 
> Now, if there is something _else_ than just the fact that it is unused
> that makes ED a good choice in the future too, that might be worth looking
> into (like NT using it for the same purpose as Linux does port 80),

Does the logic outb_p uses continue to work if you have a PCI post
card (possibly on the motherboard).  And an ISA device?

Systems without ISA slots but with ISA or LPC devices onboard must
use a PCI post card so I have trouble believing that outb_b and friends
really work as expected....


Eric
