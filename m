Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316642AbSEVSTf>; Wed, 22 May 2002 14:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSEVSTd>; Wed, 22 May 2002 14:19:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48901 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316642AbSEVSSZ>; Wed, 22 May 2002 14:18:25 -0400
Subject: Re: Linux crypto?
To: imipak@yahoo.com (Myrddin Ambrosius)
Date: Wed, 22 May 2002 19:38:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020522180350.28170.qmail@web12307.mail.yahoo.com> from "Myrddin Ambrosius" at May 22, 2002 11:03:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Ab0Y-0002We-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that Motorola has published a set of tech
> docs for their S1-range of crypto co-processors, which
> look pretty comprehensive. (The 190 looks to be a very
> nice chip, which -as best as I can tell- just plugs
> straight onto a PCI bus.) Other co-pro manufacturers
> (such as HIFN) seem to also have humungous tech
> manuals for their crypto chips.
> 
> Is anyone working on drivers for these beasties?

You might want to check on the apache and openssl lists. A lot of
crypto drivers are handled from userspace directly or with modules
that don't hit the base kernel.

> Given the ipfilter design, would there be any way to
> use those chips as an additional networking layer?
> (And, just as importantly, would there be any point?)

Some of that probably can be offloaded. You'd need code (preferably in
the user tools) that can compute if a given path through the ipchains
rules is expressable in the hardware and if so to enable it. In terms
of things like flow control and other magic try netdev@oss.sgi.com. Dave
and Jamal get very excited when they talk about NAPI but it just makes
my head hurt 8)

> Ignoring, for a second, the US export laws (which are
> no longer an issue, anyway), is there some fundamental
> reason why the IKP seems to be ignored? If there is,
> then does anyone know of any re-design/re-write
> effort?

What of it do you actually need in kernel space - encrypted file systems
certainly ought to be there but are not very well handled in Linux proper
right now - but anything else ?

