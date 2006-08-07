Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWHGPBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWHGPBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHGPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:01:39 -0400
Received: from serv07.server-center.de ([83.220.153.152]:24977 "EHLO
	serv07.server-center.de") by vger.kernel.org with ESMTP
	id S932081AbWHGPBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:01:38 -0400
From: Alexander Bigga <ab@mycable.de>
Organization: mycable GmbH
To: David Brownell <david-b@pacbell.net>
Subject: Re: RTC: add RTC class interface to m41t00 driver
Date: Mon, 7 Aug 2006 17:01:29 +0200
User-Agent: KMail/1.7.2
References: <200608041933.39930.david-b@pacbell.net> <44D4D8B0.5010103@mycable.de> <200608051323.16796.david-b@pacbell.net>
In-Reply-To: <200608051323.16796.david-b@pacbell.net>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, mgreer@mvista.com,
       a.zummo@towertech.it, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071701.29897.ab@mycable.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 22:23, you wrote:
> Discussion is now started.  :)

Hope to hear more arguments ;-)

> I suspect not all that board support is upstream yet; I can't see
> anything creating the m41t00 platform devices as required by the
> current m41t00.c driver ... neither on katana, nor any other board.

Your're right. First, I was confused too, but then Mark pointed me to a patch, 
which is never gone into mainline:

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014727.html

Be aware of the different names: m41t00 and m41txx!

> Plus, Mr. Grep tells me there's a separate m41t81 driver in
> mips/sibyte/swarm/rtc_m41t81.c ...

Oh, yes. I found it too, but didn't checked it further.

> You may end up doing more "switch (chip_type) {...}" than testing of
> the feature bits, if you get beyond those three chips.

In deed. If I want to support all.

> I noticed that the katana board uses a different scheme for the "initialize
> the system time/date" problem addressed by CONFIG_RTC_HCTOSYS, and that
> seems to be the reason for the m41t00.c driver to export an API.  (Much the
> same way that the PC-style "cmos clock" exports an API used early in x86
> booting, which likewise bypasses the RTC framework ...)
>
> I suspect there are arch-specific issues to work through there, both for
> initializing the clock at boot and for re-initializing it after resume.
> (CONFIG_RTC_HCTOSYS doesn't currently address the latter...)

This question, only Mark can unswer, or?


Alexander
-- 
Alexander Bigga     Tel: +49 4873 90 10 866
mycable GmbH        Fax: +49 4873 901 976
Boeker Stieg 43
D-24613 Aukrug      eMail: ab@mycable.de

