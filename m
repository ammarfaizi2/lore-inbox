Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281428AbRKPO0s>; Fri, 16 Nov 2001 09:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281430AbRKPO0k>; Fri, 16 Nov 2001 09:26:40 -0500
Received: from pD952AE03.dip.t-dialin.net ([217.82.174.3]:11904 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S281428AbRKPO03>; Fri, 16 Nov 2001 09:26:29 -0500
Date: Fri, 16 Nov 2001 15:25:57 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI: kbd-pw-on/WOL doesn't work anymore with 2.4.14
Message-ID: <20011116152557.A721@darkside.ddts.net>
In-Reply-To: <20011115184322.A625@darkside.ddts.net> <Pine.LNX.4.33.0111150957220.21985-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111150957220.21985-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 10:05:48AM -0800, Patrick Mochel wrote:
> Wake events for devices that are controlled via the southbridge are
> considered General Purpose Events (GPEs). On the southbridge there are two
> banks of registers for GPEs - an enable bank and a status bank.

Hm, I've checked this out, but - no matter if I enable/disable Keyboard
Power ON and/or Wake On LAN, my /proc/acpi/gpe ever contains:

GPE0: 0f 00
Status: 00 00

Btw. If I disable one of them in the BIOS, it definitely does not work
then anymore, if I enable it, it works again - just before you consider
them as fakes :).

> (The kernel behavior would still have to change a bit, since the disabling
> of the GPEs doesn't regard the events that have been set to wake the
> system up).

Thanks :) Do you have an idea about when this comes up? :)

> Wake-on-Lan is a separate issue. If it's a PCI card with PM capabilities,
> telling it to generate a wake event means setting a bit in the PCI config
> space. You can do this with setpci. Why it would stop working, I don't
> know...

Well, I have no idea about ACPI to be exact, but regarding to the not
changing GPE in my case, I could imagine that the meaning for my board
is different :)


regards,
   Mario
-- 
*axiom* welcher sensorische input bewirkte die output-aktion,
        den irc-chatter mit dem nick "dus" des irc-servers
        mittels eines kills zu verweisen?
