Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSCNUPV>; Thu, 14 Mar 2002 15:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311753AbSCNUPL>; Thu, 14 Mar 2002 15:15:11 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:39929 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311752AbSCNUOw>;
	Thu, 14 Mar 2002 15:14:52 -0500
Date: Thu, 14 Mar 2002 12:14:50 -0800
To: Wichert Akkerman <wichert@cistron.nl>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re : [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020314121450.A14791@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote :
> In article <Pine.LNX.4.33.0203141139400.26308-100000@godzilla.axis.se>,
> Bjorn Wesen  <bjorn.wesen@axis.com> wrote:
> >The orinico driver (already in the kernel) works fine with the DWL-650 card. 
> >Tried it some days ago.. not a very big field trial but I inserted the card 
> >and I got an eth0 from it and it worked, so thats the way I like it :)
> 
> Last time I tried the orinoco driver it failed to see my Lucent orinoco
> card. The wlan-cs driver from the pcmcia sources works just fine though.
> 
> Wichert.

	wvlan_cs doesn't have a maintainer. And without a maintainer
enthousiastic to push things forward and reacting to bug report and
kernel API changes, I consider the driver DEAD.
	Don't get me wrong. wvlan_cs can still do the job very well
and this is why I asked David to not remove it from the Pcmcia
package. Espcially that Orinoco is going through a restabilisation
(partly my fault - it seem so far that v8b was the most stable version
- but I still need to try v10). But there are already enough drivers
for those card out there, and a bit of consolidation might help get
things in a better shape.
	Also, note that in a lot of case, the problem is not the
orinoco driver but the kernel Pcmcia subsystem, which is not working
at all on most PCI to Pcmcia adapters, while the external Pcmcia
modules work with the proper magic incantations.
	Regards,

	Jean
