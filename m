Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTACRhO>; Fri, 3 Jan 2003 12:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTACRhO>; Fri, 3 Jan 2003 12:37:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28116 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267597AbTACRhN>;
	Fri, 3 Jan 2003 12:37:13 -0500
Date: Fri, 3 Jan 2003 17:43:23 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Richard Baverstock <beaver@gto.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGPGART for VIA vt8235, kernel 2.4.21-pre2
Message-ID: <20030103174323.GA10327@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Richard Baverstock <beaver@gto.net>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20030102145346.27a21ed9.beaver@gto.net> <20030103171617.B4502@ucw.cz> <20030103122216.39cedd3f.beaver@gto.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103122216.39cedd3f.beaver@gto.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 12:22:16PM -0500, Richard Baverstock wrote:
 > > The vt8235 is the southbridge chip and that the AGP bridge is
 > > located in the northbridge, which most likely has a different
 > > number.
 > Sorry about that, thought the AGP was in the southbridge chip. I see
 > however that someone else has submitted a patch with the correct
 > naming conventions (It does seem to change between P4X333 and P4X400
 > however).

What exactly do you mean by 'it' ? The PCI device id ?

If they share the same device ID, then Bernhards patch is
really no better...

#define PCI_DEVICE_ID_VIA_P4X333       0x3168

In fact, P4X333 defines a chipset rather than a chip.
According to ..
http://www.viatech.com/en/apollo/p4x333.jsp and
http://www.viatech.com/en/apollo/p4x400.jsp ,
the northbridge is a VT8754 in both models, so the
correct define would seem to be PCI_DEVICE_ID_VIA_8754

Just to confirm, device 3168 is the host bridge in lspci output right?
And this does all work when you run a DRI application ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
