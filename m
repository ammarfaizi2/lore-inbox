Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292248AbSB0I1T>; Wed, 27 Feb 2002 03:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292254AbSB0I1J>; Wed, 27 Feb 2002 03:27:09 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:50103 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292248AbSB0I0v>; Wed, 27 Feb 2002 03:26:51 -0500
Date: Wed, 27 Feb 2002 09:26:42 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI driver in userspace
Message-ID: <20020227082642.GA19173@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <D8E12241B029D411A3A300805FE6A2B9025761AB@montreal.eicon.com> <mailman.1014747181.29305.linux-kernel2news@redhat.com> <200202270052.g1R0qdK11879@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202270052.g1R0qdK11879@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 07:52:39PM -0500, Pete Zaitcev wrote:

[Interrupts in userspace...]

> >> Although I dont know if this is a good idea in the first place.
> > 
> > I think it depends on the interrupt frequency, and other things.
> > 
> This is why purely
> user level interrupts are IMPOSSIBLE (regardless of interrupt
> frequency).
[...]
> 2. Write a small driver that deactivates interrupts and queues
> interrupt events (with SIGIO and some other means).

This is what I meant too, and I was talking about the interrupt 
frequency because if there are too many IT, continuous polling might
be more efficient than interrupt handling with the kernel driver + 
userspace signal sending.

> Very many people are psychologically afraid of drivers
> (even though it's quite simple), and they wank those userspace
> approaches, until they hit some brick wall (interrupts being
> most common). By that time they invest so much into their code
> that they are loth to abandon broken userland drivers and
> start grappling about desperately for a way out.

It depends on the driver. If moving _all_ the driver in kernelspace
involves putting policy and other stuff into the kernel, then no. 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
