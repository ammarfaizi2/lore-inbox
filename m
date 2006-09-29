Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWI2V2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWI2V2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbWI2V2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:28:22 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:43976 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1161419AbWI2V2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:28:21 -0400
Date: Fri, 29 Sep 2006 14:27:48 -0700
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20060929212748.GA10288@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 10:40:29PM +0200, Alessandro Suardi wrote:
> On 9/29/06, John W. Linville <linville@tuxdriver.com> wrote:
> >On Fri, Sep 29, 2006 at 09:25:53PM +0200, Alessandro Suardi wrote:
> >> Dell Latitude D610, FC5-latest, ipw2200 configured to associate
> >> with a D-Link DSL-G604T (combo of router/ADSL modem/802.11g AP).
> >>
> >> 2.6.18-git8 (plus semaphore.h) is ok
> >> -git9, -git10, -git11 fail to associate
> >> -git11 with reverted wireless changes is ok
> >>
> >> Attaching diff of what I reverted in -git11 to make it work again.
> >>
> >> wpa_supplicant log of failing session available upon request.
> >
> >It looks like you reverted the WE-21 stuff.  Is your wireless-tools
> >package up to date?
> 
> Well, that's the latest I get under FC5:
> 
> [asuardi@sandman ~]$ rpm -q wireless-tools
> wireless-tools-28-0.pre13.5.1

	That's too old, the cutoff is 27-pre15.

> but indeed (-git11 minus the reverts) iwconfig says
> 
> [asuardi@sandman ~]$ iwconfig eth1
> Warning: Driver for device eth1 has been compiled with version 21
> of Wireless Extension, while this program supports up to version 19.
> Some things may be broken...

	That's exactly the point of this warning (some distro like to
kill it), I think it spells pretty clearly what's wrong. Don't say I
did not warn you...

> If you have suggestions about either upgrading wireless-tools
> from a non-FC5 repository or narrowing down the reverts, I'm
> up for giving them a go :)

	If you run a custom kernel, I think you won't see any problems
running a custom version of Wireless Tools. They are available on my
web site, pretty easy to install, and have minimal
implications. Usually distro do no customisation of my tools.
	On the other hand, FC6, which is in beta, contains already the
proper version of the tools. I have been monitoring the various distro
in the last few months before sending those WE-21 patches, and all
major distro have WT-28 in the pipeline.
	Actually, you might be able to install the wireless-tools RPM
of FC6 of FC-dev onto your FC5.

> Thanks, ciao,
> 
> --alessandro

	Have fun...

	Jean
