Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVHBTNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVHBTNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVHBTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:13:42 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:22444 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261724AbVHBTNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:13:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: 2.6.13-rc5 - ACPI regression
Date: Tue, 2 Aug 2005 21:18:51 +0200
User-Agent: KMail/1.8.1
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <20050802175336.GA2959@mail.muni.cz> <5a4c581d05080211595cc07fa3@mail.gmail.com> <20050802190526.GB2959@mail.muni.cz>
In-Reply-To: <20050802190526.GB2959@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508022118.51562.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2 of August 2005 21:05, Lukas Hejtmanek wrote:
> On Tue, Aug 02, 2005 at 08:59:08PM +0200, Alessandro Suardi wrote:
> > On 8/2/05, Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > > Hello,
> > > 
> > > newly with 2.6.13-rc5 (previous -rc1 was quite ok)
> > > 
> > > $ time cat /proc/acpi/battery/BAT0/info
> > > present:                 yes
> > > design capacity:         6000 mAh
> > > last full capacity:      6000 mAh
> > > battery technology:      rechargeable
> > > design voltage:          14800 mV
> > > design capacity warning: 600 mAh
> > > design capacity low:     300 mAh
> > > capacity granularity 1:  60 mAh
> > > capacity granularity 2:  60 mAh
> > > model number:            M6A
> > > serial number:
> > > battery type:            LIon
> > > OEM info:                ASUSTEK
> > > 
> > > real    0m32.521s
> > > user    0m0.001s
> > > sys     0m0.015s
> > 
> > Different data point, in case this might be useful... 
> > 
> > Dell Latitude C640, uptodate FC4, kernel built with stock GCC 4.0.1:
> > 
> > time cat /proc/acpi/battery/BAT0/info
> > present:                 yes
> > design capacity:         65120 mWh
> > last full capacity:      45300 mWh
> > battery technology:      rechargeable
> > design voltage:          14800 mV
> > design capacity warning: 3000 mWh
> > design capacity low:     1000 mWh
> > capacity granularity 1:  200 mWh
> > capacity granularity 2:  200 mWh
> > model number:            LIP8120DLP
> > serial number:           363
> > battery type:            LION
> > OEM info:                Sony Corp.
> 
> I did not notice before, but my values (capacity and so on) are completely
> wrong. It should contain values in mWh instead of mAh.

There's a new kernel boot oprion ec_polling that you may want to try.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
