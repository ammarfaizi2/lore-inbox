Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289853AbSAWNTj>; Wed, 23 Jan 2002 08:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSAWNT3>; Wed, 23 Jan 2002 08:19:29 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:43460 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289853AbSAWNTQ>; Wed, 23 Jan 2002 08:19:16 -0500
Date: Wed, 23 Jan 2002 14:19:06 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Timothy Covell <timothy.covell@ashavan.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020123125545.A5882@suse.cz>
Message-ID: <Pine.LNX.4.40.0201231411240.31513-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Vojtech Pavlik wrote:
> Won't ACPI idle do that well enough?

yes ... and no!
first: my patch is useless, if you don't activate acpi idle calls ...
second: the idle calls will not save power on an athlon/duron/athlon xp ,
unless a specific bit in the chipset is set, which will cause the chipset
to disconnect the frontside bus of the cpu ... and this is what the patch
does: it sets only the bit in the northbridge of the kt133/kx133 and
kt266/266a chipset ... -> now the acpi idle calls will bring power saving
and lesser temperature
the patch inserts a pci_quirk function which sets the bit in the
northbridge ... (at the boot-prompt you have to pass the comment
amd_disconnect=yes to use this function ...)

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

