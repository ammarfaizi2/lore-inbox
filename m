Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271171AbTGPWcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271170AbTGPWcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:32:47 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:49321 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S271157AbTGPWck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:32:40 -0400
Date: Thu, 17 Jul 2003 08:47:18 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030716224718.GA4612@zip.com.au>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716073135.GA5338@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 12:31:35AM -0700, Greg KH wrote:
> Please change them to =m so that it's easier to try to debug this.

Done.

> Then just load the i2c_piix4 module.  If things still work just fine,
> then try the i2c-adm1021 driver.  See what the kernel log says then.

All went well till the last step of loading the adm1021 driver. Then
things got seriously nap-inducing (I fell asleep waiting for cd to
complete). rmmoding the module did not help in any way. Here's the
dmesg stuff I managed to scrounge of what happened during modprobe
adm1021. Essentially, if I remember right, the system was fine till
about the registering 0-004d line... then time went sloooooooowly
as did everything else and a nap was induced.

i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0018
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=30, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=30, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0019
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=32, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=32, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 001a
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=34, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=34, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0029
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=52, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=52, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 002a
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=54, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=54, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 002b
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=56, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=56, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 004c
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=98, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=98, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 004d
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=9a, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=00, CMD=09, ADD=9a, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=02, ADD=9b, DAT0=ff, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=02, ADD=9b, DAT0=08, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=fe, ADD=9b, DAT0=08, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=fe, ADD=9b, DAT0=49, DAT1=ff
registering 0-004d
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=0b, ADD=9a, DAT0=00, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=0c, ADD=9a, DAT0=00, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=0d, ADD=9a, DAT0=00, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=0e, ADD=9a, DAT0=00, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=09, ADD=9a, DAT0=00, DAT1=ff
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=0a, ADD=9a, DAT0=04, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 004e
i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=02, ADD=9c, DAT0=9b, DAT1=ff
i2c_adapter i2c-0: Error: no response!
i2c_adapter i2c-0: Transaction (post): CNT=04, CMD=02, ADD=19, DAT0=9b, DAT1=ff
atkbd.c: Unknown key (set 2, scancode 0x82, on isa0060/serio0) pressed.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
