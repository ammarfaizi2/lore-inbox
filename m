Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSC0WiC>; Wed, 27 Mar 2002 17:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293159AbSC0Whw>; Wed, 27 Mar 2002 17:37:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8198 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293135AbSC0Whl>; Wed, 27 Mar 2002 17:37:41 -0500
Subject: Re: IDE and hot-swap disk caddies
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 27 Mar 2002 22:51:52 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        andre@linux-ide.org (Andre Hedrick), wakko@animx.eu.org (Wakko Warner),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020327222900.GO19837@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Mar 27, 2002 11:29:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qMGm-0006J0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have seen USB mass storage devices with ide connector on them, so it
> is certainly possible to translate between scsi and ide. If it makes
> sense from performance standpoint.... I don't know.

SCSI->IDE command translation isnt too hard providing you stick to simple
stuff and blindly ignore things like ATAPI, SMART, and all the control
stuff. The moment you get into the complex stuff its deeply unfunny.

On the read/write side SCSI->IDE command mapping generally works out. Its
not pretty on the corner cases (like error mapping) and it does mean you
have a lot of excess overhead and potentially serious problems with performance
because IDE (well ATA technically) is very very sensitive to round trip time
