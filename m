Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSHDPgj>; Sun, 4 Aug 2002 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317981AbSHDPgj>; Sun, 4 Aug 2002 11:36:39 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:36876 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S317977AbSHDPgj>; Sun, 4 Aug 2002 11:36:39 -0400
Message-Id: <200208041540.RAA29280@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "hps@intermeta.de" <hps@intermeta.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 04 Aug 2002 17:40:07 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <aija6e$brm$1@forge.intermeta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: No Subject
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002 13:28:46 +0000 (UTC), Henning P. Schmiedehausen
wrote:

>Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:
>>On 4 Aug 2002, Alan Cox wrote:
>>> On Sat, 2002-08-03 at 23:16, Bartlomiej Zolnierkiewicz wrote:

>>> > Just rethough it. What if chipset is in compatibility mode?
>>> > Like VIA with base addresses set to 0?
>>>
>>> If we found a register that was marked as unassigned with a size then we
>>> would map it to a PCI address. That would go for BAR0-3 on any PCI IDE
>>> device attached to the south bridge.
>
>>In compatibility mode IDE chipsets have IO at legacy ISA ports and
>>PCI_BASE_ADDRESS0-3 are set to them or to zero (at least on VIA).
>>And they can't be programmed to any other ports (unless native mode).

>this sounds like a problem that I have with the ServerWorks OSB5
>chipset. I actually have PCI_BASE_ADDRESS0-3 at 0 and
>PCI_BASE_ADDRESS4 = 0x3a0.
>
>Does this hold true here, too? Or is this VIA specific?

PCI IDE controller chips in compatibility mode may exhibit the
following BAR0-3 values (sorted by likelihood of occurance):

most likely:  BAR0-3 are all zero
rare       :  BAR0-3 show the legacy IDE port values
very rare  :  BAR0-3 contain garbage

In fact, the best strategy is to *ignore* BAR0-3 in compatibility mode
because they have no meaning then!

Ciao,
  Dani


