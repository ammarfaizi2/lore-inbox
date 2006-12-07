Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162553AbWLGR2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162553AbWLGR2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162561AbWLGR2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:28:02 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:1343 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162553AbWLGR2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:28:00 -0500
Message-ID: <45784F0C.7040005@xs4all.nl>
Date: Thu, 07 Dec 2006 18:27:40 +0100
From: Bauke Jan Douma <bjdouma@xs4all.nl>
Reply-To: bjdouma@xs4all.nl
Organization: a training zoo
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Daniel Ritz <daniel.ritz@gmx.ch>,
       Daniel Drake <dsd@gentoo.org>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Tomasz Koprowski <tomek@koprowski.org>
Subject: Re: RFC: PCI quirks update for 2.6.16
References: <20061207132430.GF8963@stusta.de> <20061207165352.9cb61023.vsu@altlinux.ru>
In-Reply-To: <20061207165352.9cb61023.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote on 07-12-06 14:53:
> On Thu, 7 Dec 2006 14:24:30 +0100 Adrian Bunk wrote:
> 
>> While checking how to fix the VIA quirk regressions for several users
>> introduced into -stable in 2.6.16.17, I started looking through all
>> drivers/pci/quirks.c updates up to both -stable and 2.6.19.
>>
[snip]
>>
>>
>> Bauke Jan Douma (1):
>>       PCI: quirk for asus a8v and a8v delux motherboards
> 
> This quirk will cause breakage for people who used an external PCI
> soundcard with these boards - the builtin sound chip which was
> invisible before may become the first audio device.

I'm afraid I don't understand the problem described here, when
ALSA can assign any arbitrary index number of a user's choice
to cards that are detected.

Indeed, on my system (an A8V Deluxe motherboard, with this
quirk active), my first soundcard (given index=0) is an offboard
Creative SB Live, and the onboard card I have assigned index=1.

I for one need this quirk to get both soundcards at all (which
I need) -- no matter what indexing order.

> It also enables the MC97 device, which does not really work (there is
> no MC97 codec attached to the controller at least on A8V Deluxe; I'm
> not sure if there is some other variant of this board which has MC97,
> but it seems unlikely).

This one can be disabled separate of the AC97 -- let me get back
on that.  I, for one (however much that is), don't need it either.


bjd
