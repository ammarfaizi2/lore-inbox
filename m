Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310528AbSCPTdl>; Sat, 16 Mar 2002 14:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310529AbSCPTdV>; Sat, 16 Mar 2002 14:33:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31275 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310528AbSCPTdN>; Sat, 16 Mar 2002 14:33:13 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <Pine.LNX.4.33.0203151659060.1379-100000@home.transmeta.com>
	<3C92AD1F.30909@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Mar 2002 12:27:21 -0700
In-Reply-To: <3C92AD1F.30909@mandrakesoft.com>
Message-ID: <m1lmcsxqhy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> 
> (thinking vaguely long-term)
> 
> I wonder if mochel already code for this, or has thought about this... Just like
> 
> suspend, IMO we ideally should use the device tree to shutdown the system,
> agreed?
> 
> Further, I wonder if the reboot/shutdown notifiers can be replaced with device
> tree control over those events...

Please for the Linux booting Linux scenario it is mandatory we get this right
for reboot.  I know for a fact that currently we leave active receive buffers on
network cards when we reboot. (If you haven't downed the interface).  So it
is possible for a network packet to come in and hose a machine that is rebooting.

Occasionally I test my linux booting linux code by loading memtest86 to make certain
I don't have something like that going on.  And the first time I tried it I hadn't
downed the interfaces and I actually saw a network packet come in and corrupt
memory.  I also have similar reports from other about disk subsystems.

Eric
