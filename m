Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSKHNQY>; Fri, 8 Nov 2002 08:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSKHNQY>; Fri, 8 Nov 2002 08:16:24 -0500
Received: from kim.it.uu.se ([130.238.12.178]:20433 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261874AbSKHNQX>;
	Fri, 8 Nov 2002 08:16:23 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15819.47795.543312.435264@kim.it.uu.se>
Date: Fri, 8 Nov 2002 14:22:59 +0100
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <Pine.LNX.4.44.0211080804280.27141-100000@montezuma.mastecende.com>
References: <Pine.GSO.3.96.1021108131625.3217B-100000@delta.ds2.pg.gda.pl>
	<Pine.LNX.4.44.0211080804280.27141-100000@montezuma.mastecende.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > On Fri, 8 Nov 2002, Maciej W. Rozycki wrote:
 > 
 > >  Well, the "lapic" option should override the DMI setting, not the
 > > APICBASE availability check.  Anyway, I don't insist on this that much --
 > > while I think consistency is good, none of the "*apic" options are
 > > actually a necessity for me.  If one needs the option, one may still cook
 > > an appropriate patch oneself. 
 > 
 > I think the nolapic is definitely needed because i've come across a number 
 > of bug reports where the simplest solution would be to just disable the 
 > local apic.

People with broken boxes should send their DMI data to me so I can add
their boxes to the local APIC blacklist in dmi_scan.c. "nolapic" is
simply a workaround for the absence of this DMI data.

Notice how silent the Inspiron 8k users are now that the DMI black
list is implemented...

/Mikael
