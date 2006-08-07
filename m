Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWHGO4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWHGO4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHGO4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:56:03 -0400
Received: from serv07.server-center.de ([83.220.153.152]:39084 "EHLO
	serv07.server-center.de") by vger.kernel.org with ESMTP
	id S1750930AbWHGOz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:55:56 -0400
From: Alexander Bigga <ab@mycable.de>
Organization: mycable GmbH
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RTC: add RTC class interface to m41t00 driver
Date: Mon, 7 Aug 2006 16:55:50 +0200
User-Agent: KMail/1.7.2
Cc: david-b@pacbell.net, mgreer@mvista.com, a.zummo@towertech.it,
       linux-kernel@vger.kernel.org
References: <200608041933.39930.david-b@pacbell.net> <200608051213.50308.david-b@pacbell.net> <20060807.020919.15248103.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060807.020919.15248103.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071655.50946.ab@mycable.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 19:09, Atsushi Nemoto wrote:
> > It would have made more sense to me to have the M41T81 and M41T85 be
> > in a different driver, because of the incompatible register layout.
> > That's the more traditional approach.
>
> Now I'm thinking this way.  Still thinking...

Yes, but on the other side: except of this single shift in the registers, it 
works in the m41txx (or what the name will be) and won't do any extra work to 
the driver.
Even the m41t80 and m41t81 differs in their features. So you always have to 
distinguish inside the driver.

> My real target is M41T80, which seems a subset of M41T81.
> (Sorry for not writing this before.)

My target is a M41ST85.

> So the next theme would be how we support M41T8x chips.  I think
> Alexander's rtc-m41txx is good candidate for them.

There are also M41st9x chips and M41t6x chips and a M41t11... But ok, most 
difference is watchdog/alarm or not.

> Then M41T00 users can choose rtc-ds1307 or rtc-m41t00.  Not so bad, I
> think.

As long, as the user will be pointed out this possibilties in the Kconfig - I 
agree.


Alexander
-- 
Alexander Bigga     Tel: +49 4873 90 10 866
mycable GmbH        Fax: +49 4873 901 976
Boeker Stieg 43
D-24613 Aukrug      eMail: ab@mycable.de

