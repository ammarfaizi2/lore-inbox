Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKQMaK>; Fri, 17 Nov 2000 07:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbQKQMaA>; Fri, 17 Nov 2000 07:30:00 -0500
Received: from 62-6-231-42.btconnect.com ([62.6.231.42]:49802 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129111AbQKQM3x>;
	Fri, 17 Nov 2000 07:29:53 -0500
Date: Fri, 17 Nov 2000 11:58:27 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Jordan <ledzep37@home.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <14869.6415.500026.432150@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.21.0011171154250.8176-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Mikael Pettersson wrote:
> You have a user-space program which parses /proc/cpuinfo instead of
> executing CPUID itself, so it breaks.

Hi Mikael,

Arguably, it is always better to parse /proc/cpuinfo instead of executing
CPUID directly (think PCI -- drivers should _NOT_ get their irq/io/etc
values from config space directly but only what the kernel puts on a plate
for them in the struct pci_dev).

So, one could imagine the kernel which emulates in software some of the
processor features and then CPUID would lie but /proc/cpuinfo would tell
the truth.

Also, Linux is very stable wrt to application interfaces (I compare Linux
with Linux and not Linux with "non-Linux", cf 1Cor 2:13) so one can safely
rely on the exported data formats to stay always the same (to a reasonable
extent).

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
