Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292358AbSBPMXI>; Sat, 16 Feb 2002 07:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292359AbSBPMW7>; Sat, 16 Feb 2002 07:22:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292358AbSBPMWs>; Sat, 16 Feb 2002 07:22:48 -0500
Subject: Re: Disgusted with kbuild developers
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 16 Feb 2002 12:36:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), esr@thyrsus.com,
        davej@suse.de (Dave Jones),
        arjan@pc1-camc5-0-cust78.cam.cable.ntl.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C6DE6A1.2B5717BE@mandrakesoft.com> from "Jeff Garzik" at Feb 15, 2002 11:57:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c44r-000670-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) CONFIG_FOO_OPTION requires CONFIG_FOO
> 2) CONFIG_SUBSYS2 requires CONFIG_SUBSYS1
> 
> The reason why #2 is different, is the desired prompting and symbol
> behavior for the end user.

You can tell a subsystem from a module quite reliably because it has a 
subtree of dependant questions. Now you might get it wrong, but its still
correct to prompt for the subtree of questions again since if you've just
forced on eepro100 for example, you do want to be asked mmio/pio and the
like

> If CONFIG_SUBSYS1="" and CONFIG_SUBSYS2="", then we gotta prompt for
> CONFIG_SUBSYS1, but -after- CONFIG_SUBSYS2 is prompted for.

The graph tells you that. The only interesting case I could find is the
negation one - some rules are  A conflicts with B which makes the UI side
much more fun
