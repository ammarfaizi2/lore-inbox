Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129198AbRBMQ6x>; Tue, 13 Feb 2001 11:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbRBMQ6o>; Tue, 13 Feb 2001 11:58:44 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:41928 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129129AbRBMQ6c>; Tue, 13 Feb 2001 11:58:32 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michèl Alexandre Salim 
	<salimma1@yahoo.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PCI GART (?)
Date: Tue, 13 Feb 2001 17:58:02 +0100
Message-Id: <19350108102946.2444@mailhost.mipsys.com>
In-Reply-To: <E14Sf6W-0001iU-00@the-village.bc.nu>
In-Reply-To: <E14Sf6W-0001iU-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have RTFM but on the matter of enabling DRI for the
>> ATI Mobility video chipset, which on that notebook is
>> a PCI model, there is practically nil information. The
>> DRI website mentions using PCI GART, but there is no
>> option for that in the kernel. How do I enable this?
>
>You need to get XFree86 CVS and really the right place to ask
>is the XFree86 folks. The standard kernel doesnt include pcigart

Michel, FYI, PCI GART is a feature of the video chipset, not the host
bridge, and so is not directly related to the kernel (there's no generic
PCI GART driver like there is an AGP GART driver). AFAIK, the only PCI
GART implementation so far is for rage 128 (or derived, like the M3), and
is available in the "ati-pcigart-0-0-1-branch" DRI CVS branch. You need
to compile the DRM inside this X server version, not the kernel one.

Ben.



