Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWFSDyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWFSDyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 23:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWFSDyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 23:54:55 -0400
Received: from ash25e.internode.on.net ([203.16.214.182]:19728 "EHLO
	ash25e.internode.on.net") by vger.kernel.org with ESMTP
	id S1751125AbWFSDyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 23:54:55 -0400
From: ocilent1 <ocilent1@gmail.com>
Reply-To: ocilent1@gmail.com
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: sound skips on 2.6.16.17
Date: Mon, 19 Jun 2006 11:54:33 +0800
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
References: <4487F942.3030601@att.net.mx> <200606181204.29626.ocilent1@gmail.com> <20060618044047.GA1261@tuatara.stupidest.org>
In-Reply-To: <20060618044047.GA1261@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191154.33747.ocilent1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 12:40, Chris Wedgwood wrote:
> On Sun, Jun 18, 2006 at 12:04:29PM +0800, ocilent1 wrote:
> > (PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch)
> > that is causing the sound stuttering/skipping problems for our users
> > with VIA chipsets. Backing out the first patch alone did not fix the
> > problem (PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back
> > out the 2nd patch, you need to have initially backed out the first
> > patch, due to the way the patches apply in series.
>
> what mainboard/CPU do you have there?
>
> what does 'lspci -n' say?

It is a compaq presario with KM266 mobo AMD XP2200+

[root@localhost ~]# lspci -n
00:00.0 0600: 1106:3116
00:01.0 0604: 1106:b091
00:0b.0 0200: 10ec:8139 (rev 10)
00:10.0 0c03: 1106:3038 (rev 80)
00:10.1 0c03: 1106:3038 (rev 80)
00:10.2 0c03: 1106:3038 (rev 80)
00:10.3 0c03: 1106:3104 (rev 82)
00:11.0 0601: 1106:3177
00:11.1 0101: 1106:0571 (rev 06)
00:11.5 0401: 1106:3059 (rev 50)
01:00.0 0300: 10de:002d (rev 15)


[root@localhost ~]# lspci -m
00:00.0 "Host bridge" "VIA Technologies, Inc." "VT8375 [KM266/KL266]
Host Bridge" "FIRST INTERNATIONAL Computer Inc" "Unknown device 9012"
00:01.0 "PCI bridge" "VIA Technologies, Inc." "VT8633 [Apollo Pro266 AGP]" "" 
""
00:0b.0 "Ethernet controller" "Realtek Semiconductor Co., Ltd."
"RTL-8139/8139C/8139C+" -r10 "FIRST INTERNATIONAL Computer Inc"
"Unknown device 9012"
00:10.0 "USB Controller" "VIA Technologies, Inc." "VT82xxxxx UHCI USB
1.1 Controller" -r80 "FIRST INTERNATIONAL Computer Inc" "Unknown
device 9012"
00:10.1 "USB Controller" "VIA Technologies, Inc." "VT82xxxxx UHCI USB
1.1 Controller" -r80 "FIRST INTERNATIONAL Computer Inc" "Unknown
device 9012"
00:10.2 "USB Controller" "VIA Technologies, Inc." "VT82xxxxx UHCI USB
1.1 Controller" -r80 "FIRST INTERNATIONAL Computer Inc" "Unknown
device 9012"
00:10.3 "USB Controller" "VIA Technologies, Inc." "USB 2.0" -r82 -p20
"FIRST INTERNATIONAL Computer Inc" "Unknown device 9012"
00:11.0 "ISA bridge" "VIA Technologies, Inc." "VT8235 ISA Bridge"
"FIRST INTERNATIONAL Computer Inc" "Unknown device 9012"
00:11.1 "IDE interface" "VIA Technologies, Inc."
"VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE" -r06 -p8a
"FIRST INTERNATIONAL Computer Inc" "Unknown device 9012"
00:11.5 "Multimedia audio controller" "VIA Technologies, Inc."
"VT8233/A/8235/8237 AC97 Audio Controller" -r50 "FIRST INTERNATIONAL
Computer Inc" "Unknown device 9012"
01:00.0 "VGA compatible controller" "nVidia Corporation" "NV5M64 [RIVA
TNT2 Model 64/Model 64 Pro]" -r15 "" ""

-- 
*ocilent1
