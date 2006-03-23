Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWCWSVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWCWSVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWCWSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:21:51 -0500
Received: from mail.parknet.jp ([210.171.160.80]:7689 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1422645AbWCWSVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:21:49 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp>
	<200603221121.16168.kernel@kolivas.org>
	<87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
	<20060323170413.GA20234@rhlx01.fht-esslingen.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 24 Mar 2006 03:21:39 +0900
In-Reply-To: <20060323170413.GA20234@rhlx01.fht-esslingen.de> (Andreas Mohr's message of "Thu, 23 Mar 2006 18:04:13 +0100")
Message-ID: <871wwtja30.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:

> Should I do a public request for chipset testing?
> (I wrote a small test app here that would hopefully identify a buggy
> chipset).

I think almost ICH4 is not buggy.  But probably current approach is safe.
So, I added "pmtmr_good" to disable the workaround instead.

I posted probably similar one for mainly ICH4 users.
http://marc.theaimsgroup.com/?l=linux-kernel&m=114297656924494&w=2

> Data that I have collected from internet snippets (mostly Intel errata
> documents):
> Affected (PCI ID / rev):
>   - ICH4???
>   - PIIX4 A0 (0x7113 / 00?), A1 (0x7113 / 00?), B0 (0x7113 / 01?)
>   - PIIX4E A0 (0x7113 / 02?)
> Probably fixed (PCI ID / rev):
>   - PIIX4M A0 (0x7113 / 03?)
>
> My Toshiba Satellite 4280 seems to have non-buggy PIIX4M
> (since it's PCI rev. 03), haven't had time to test reliability yet, though.

I tested PIIX4E (yes, really buggy), ICH7, VT88237. And ICH6 was
reported as sane.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
