Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWGYULp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWGYULp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGYULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:11:45 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:14345 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964851AbWGYULo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:11:44 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Debugging APM - cat /proc/apm produces oops
Date: Tue, 25 Jul 2006 22:11:40 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200607231630.53968.linux@rainbow-software.org> <1153854921.4725.22.camel@localhost>
In-Reply-To: <1153854921.4725.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607252211.41038.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 21:15, Alan Cox wrote:
> On Sul, 2006-07-23 at 16:30 +0200, Ondrej Zary wrote:
> > Hello,
> > cat /proc/apm produces oops on my DTK notebook. Using "apm=broken-psr"
> > kernel parameter fixes that but I lose the battery info. I'd like to have
> > the battery info (and it works fine in Windows) so I want to debug it and
> > (hopefully) fix.
>
> If broken-psr is needed can you also send me a dmidecode and lspci -vxx
> dump so I can automate that bit.

I just found that there is another problem with this machine - DMI :)
Both kernel and dmidecode says that the DMI is not present - so one would say 
that the BIOS does not support DMI.
But wait... HWiNFO32 for DOS shows working DMI 2.0 with real data (although 
some data is from Intel Trajan reference board, apparently not changed by 
BIOS engineer...)
Examining $F000 BIOS segment revealed that the "_DMI_" signature is not 
present. But there is "_DMI20_" - and the header does not seem to match. I 
can see all the strings (like "Trajan") there...
Anyone interested in BIOS dump?

-- 
Ondrej Zary
