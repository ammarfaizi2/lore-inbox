Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSABXAO>; Wed, 2 Jan 2002 18:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbSABXAE>; Wed, 2 Jan 2002 18:00:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5903 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287158AbSABW76>; Wed, 2 Jan 2002 17:59:58 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 23:09:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102173419.A21165@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 05:34:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LuW5-0005w3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What?  Perhaps we're talking at cross-prorposes here.  What I'm proposing
> is that /proc/dmi should be a world-readable /proc file with the property
> that 
> 	cat /proc/dmi
> 
> gives you a DMI report.  No root privileges or SUID programs needed.
> Surely that would be an improvement on having to run Arjan's dmidecode as
> root or requiring it to be SUID.

Of course it isnt. cat /proc/dmi executes kernel mode code which is totally
priviledged. /sbin/dmidecode executes slightly priviledged code which will
core dump not crash the box if it misparses the mapped table.

Also you might want to restrict or lie about DMI access. It may include serial
numbers or other info considered private.
