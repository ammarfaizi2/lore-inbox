Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262169AbRETVAD>; Sun, 20 May 2001 17:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262136AbRETU7y>; Sun, 20 May 2001 16:59:54 -0400
Received: from t2.redhat.com ([199.183.24.243]:50676 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262115AbRETU7n>; Sun, 20 May 2001 16:59:43 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010520164700.H4488@thyrsus.com> 
In-Reply-To: <20010520164700.H4488@thyrsus.com>  <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> 
To: esr@thyrsus.com
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 21:59:39 +0100
Message-ID: <22842.990392379@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



esr@thyrsus.com said:
>  I'm nervous that if we go down this path we will end up with a
> thicket of modes and a combinatorial explosion in ruleset complexity,
> leading immediately to a user configuration experience that is more
> complex than necessary, and eventually to an unmaintainable mess in
> the rulesfiles.

Having too many such modes would be a horrible mess, I agree.

> In order to prevent that happening, I would like to have some
> recognized criterion for configuration cases that are so perverse that
> it is a  net loss to accept the additional complexity of handling them
> within the configurator.

> A lot of people (including, apparently, you) are saying there are no
> such cases.  I wonder if you'll change your minds when you have to
> handle the overhead yourselves? 

Of course there are such cases. The criterion is that the code does not 
compile or if it did, it could never be expected to work - like SCSI drivers
without SCSI generic, or PCI devices without CONFIG_PCI.

This is the major criterion which has defined the dependencies already in 
the config files.

You want to add a new mode which hides some of the more esoteric options. 
That's fine. So do so, and then we have two modes. It's still not an 
unmaintainable mess. 

If having even two modes is going to be too troublesome, then keep the one
we have. You can try to simplify it later by encouraging individual
maintainers to hide stuff behind CONFIG_*_ADVANCED options. But keep that
strictly separate from the CML2 discussion.

--
dwmw2


