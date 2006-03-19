Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWCSSSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCSSSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWCSSSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:18:42 -0500
Received: from main.gmane.org ([80.91.229.2]:41451 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932155AbWCSSSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:18:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 20:18:41 +0200
Message-ID: <dvk79k$hf4$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org> <yw1xd5gi381h.fsf@agrajag.inprovide.com> <dvjsa6$i92$1@sea.gmane.org> <yw1xslpez928.fsf@agrajag.inprovide.com> <dvk4tv$9j9$1@sea.gmane.org> <yw1xbqw2z50o.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.49.226
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> OK, I just used the simpler (and newer) of the two versions that were
> posted, and modified as suggested by someone.  Does my version work on
> your machine?

I did not try it, but because of the code and the outputs I got when I tried
to find the problem I'm sure it would work.

>> Anyway, my suggestion remains, that the
>> +       if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
>> +               return;
>> +       if (dev->device != PCI_DEVICE_ID_VIA_8237)
>> +               return;
>>
>> might be not needed at all as it is not ASUS specific.
> 
> Doesn't it depend on the BIOS?  My BIOS lets me choose between
> "automatic" and "disabled" for the onboard sound.

I don't see how that setting could change the device ID or the vendor ID. As
I understood the above code will simply not try to enable the sound device
if:
a) the vendor is not ASUSTEK
b) the device is not ID is not PCI_DEVICE_ID_VIA_8237

For a) it means that an MSI/Epox/whatever board with the same VIA chipset
and the same problem will not be handled. For b) see my previous comment
(and your concerns).

Well, it would be nice if a kernel developer could comment on it, or simply
include the right version in some upcoming release. ;-)

Andras
-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


