Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292920AbSBVSvz>; Fri, 22 Feb 2002 13:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292909AbSBVSvq>; Fri, 22 Feb 2002 13:51:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292920AbSBVSve>;
	Fri, 22 Feb 2002 13:51:34 -0500
Message-ID: <3C769325.A8533881@mandrakesoft.com>
Date: Fri, 22 Feb 2002 13:51:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Steffen Persvold <sp@scali.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org>
		<20020220103539.B32211@vger.timpanogas.org>
		<3C73DC34.E83CCD35@mandrakesoft.com>
		<20020220.093034.112623671.davem@redhat.com>
		<20020220110004.A32431@vger.timpanogas.org>
		<20020220145449.A1102@vger.timpanogas.org>
		<20020220151053.A1198@vger.timpanogas.org>
		<3C7626A9.330A9249@scali.com>
		<20020222111756.A11081@vger.timpanogas.org> <15478.37161.767510.748999@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> In the context of Linux, this is certainly not true.  Linux/ia64
> always has been LP64 (i.e., sizeof(long)=8).  Perhaps you're confusing
> this with the hp-ux C compiler, which defaults to ILP32?  Another
> potential source of confusion is Windows, which uses the P64 data
> model (only pointers and "long long" are 64 bits).

Tru64's vendor compiler has similar features, though I'm not sure if
32-bit mode is enabled by default.  Noteably, Netscape for Tru64 is
compiled with this 32-bit mode, IIRC

People would be surprised how much ground alpha axp broke in userland,
years ago, simply by being one of the first Linux platforms where long
!= int

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
