Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272510AbRIFTKp>; Thu, 6 Sep 2001 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272509AbRIFTKf>; Thu, 6 Sep 2001 15:10:35 -0400
Received: from clavin.efn.org ([206.163.176.10]:54224 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S272510AbRIFTK2>;
	Thu, 6 Sep 2001 15:10:28 -0400
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15255.51738.928064.590637@tzadkiel.efn.org>
Date: Thu, 6 Sep 2001 12:10:18 -0700
To: wietse@porcupine.org (Wietse Venema)
Cc: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <20010906182518.3C907BC06C@spike.porcupine.org>
In-Reply-To: <15255.48233.706962.451093@tzadkiel.efn.org>
	<20010906182518.3C907BC06C@spike.porcupine.org>
X-Mailer: VM 6.95 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wietse Venema writes:
 > Steve VanDevender:
 > > Wietse Venema writes:
 > >  > If an MTA receives a mail relaying request for user@domain.name
 > >  > then it would be very useful if Linux could provide the MTA with
 > >  > the necessary information to distinguish between local subnetworks
 > >  > and the rest of the world. Requiring the local sysadmin to enumerate
 > >  > all local subnetwork blocks by hand is not practical.
 > > 
 > > I think you're making a couple of unjustified assumptions here:
 > 
 > You are making unjustified assumptions:
 > 
 > If the kernel knows about subnets, then an application should be
 > able to find out about them. Whether or not you agree with the
 > application's reasons does not matter.

The only justification I've seen you offer so far for wanting this
netmask information is apparently to use to decide whether your MTA
should allow relaying to another host or not.  As a sysadmin who manages
several large MTA installations I'd say that allowing relaying to or
from other hosts on "local" subnets as determined by available
interfaces and netmasks should at best be an option, and that option
should be off by default -- there are too many common situations where
that would open an MTA to abuse, or circumvent other controls one would
want to put on an MTA's relaying permissions.  If you were just talking
about the problem of determining which IP addresses are bound to the
host, I wouldn't disagree with you, but you keep saying things that make
it look like you really want to have your MTA permit relaying by default
to all hosts in "local" networks based on available interfaces and
netmasks.

So if the only reason your application wants this information is to
apply it in a useless or even awful way, I'd have to question why you
feel the need to obtain the information at all.  In a pure sense maybe
an application should be able to obtain this information, but in a
practical sense if there's no good use for the information in this
specific situation then why make a big fuss about not being able to
obtain it?
