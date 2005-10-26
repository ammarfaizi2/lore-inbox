Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVJZKco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVJZKco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVJZKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:32:44 -0400
Received: from main.gmane.org ([80.91.229.2]:37335 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932261AbVJZKcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:32:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Re: Call for PIIX4 chipset testers
Date: Wed, 26 Oct 2005 12:12:51 +0200
Organization: Dimension of Decked
Message-ID: <871x28k2n0.fsf@obelix.mork.no>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
	<4DBF8B37C1%linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 42.250.120.148.in-addr.arpa
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:Hh6pEc0prypf3Xzq37QaFzQqAs0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Salt <linux@youmustbejoking.demon.co.uk> writes:

>   $ dmesg | grep PIIX4
>   PCI quirk: region 5000-503f claimed by PIIX4 ACPI
>   PCI quirk: region 4000-401f claimed by PIIX4 SMB
>   PIIX4 devres C PIO at 0100-0107
>   PIIX4 devres I PIO at 00e0-00e3
>   PIIX4 devres J PIO at 00f9-00fc
>   PIIX4: IDE controller at PCI slot 0000:00:07.1
>   PIIX4: chipset revision 1
>   PIIX4: not 100% native mode: will probe irqs later
>   uhci_hcd 0000:00:07.2: Intel Corporation 82371AB/EB/MB PIIX4 USB
>   $
>
> Machine is a Compaq Armada M700; /proc/ioports & lspci output are attached.

Interesting.  The second device here is probably a SMC FDC37N971?  I
remember there used to be some hacks around because it was relocated
from the default 0x3f0 or 0x370 to 0xe0.  This affected the smc-ircc
driver among other things.  See for example
http://www.lrr.in.tum.de/~acher/m300/

(This was on a M300, but I guess the M700 has the same problem)

Unfortunately both of the M300s I have around here are now stone dead,
so I can't test the patch.


Bjørn
-- 
You sound like a real Nazi.

