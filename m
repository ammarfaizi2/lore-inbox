Return-Path: <linux-kernel-owner+w=401wt.eu-S1751844AbWLNIfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWLNIfS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWLNIfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:35:17 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:48857 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbWLNIew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:34:52 -0500
X-Greylist: delayed 1415 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 03:34:52 EST
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Greg.Chandler@wellsfargo.com, linux-kernel@vger.kernel.org
Subject: Re: Interphase Tachyon drivers missing.
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
References: <E8C008223DD5F64485DFBDF6D4B7F71D023BAE21@msgswbmnmsp25.wellsfargo.com>
	<200612140827.31858.eike-kernel@sf-tec.de>
Date: Thu, 14 Dec 2006 03:11:16 -0500
In-Reply-To: <200612140827.31858.eike-kernel@sf-tec.de> (Rolf Eike Beer's message of "Thu, 14 Dec 2006 08:27:26 +0100")
Message-ID: <yq18xha28yj.fsf@sermon.lab.mkp.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eike" == Rolf Eike Beer <eike-kernel@sf-tec.de> writes:

Eike> Am Mittwoch, 13. Dezember 2006 17:51 schrieb
Eike> Greg.Chandler@wellsfargo.com:
>> I'm not sure about the driver being cpqfc, I know in 2.6.0 & 1 the
>> driver was definitely iphase.c/h/o I do know the chipset was used
>> by almost everyone, Compaq/HP/DEC and Interphase's namebrand cards.
>> 
>> I also know that the driver is still working in 2.4.33 my slackware
>> 11 default kernel picked up the card, which suprised me to say the
>> least...  I won't have time to spend a weekend on it until about
>> christmas. {or probably christmas day is more likely} Even then I
>> can't make any kind of promise that I can do anything useful about
>> it...

Eike> Ok, than we're likely talking about different things. Maybe just
Eike> another driver for that chipset. If I'll ever find some time
Eike> I'll have a look on this one too.

The ip5526 driver was removed way back due to lack of interest.  It
only drove a limited set of cards from one vendor.

The interphase cards used a "real" Tachyon (HPFC-5000) chip.  The
controllers we usually discuss in the context of cpqfc have TachLite
(HPFC-51xx and later).

Tachyon is a really old chip and it's not completely compatible with
TachLite from a programming perspective.  It also doesn't have
contemporary features like - cough - PCI-support.  The
GSC/EISA/PCI/whatever glue chip was vendor-specific.

I'm sure the ip5526 driver could be revived -- it's not very big.  But
I doubt there are many cards out there that haven't been scrapped.

-- 
Martin K. Petersen      http://mkp.net/
