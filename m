Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRB0Qte>; Tue, 27 Feb 2001 11:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRB0QtY>; Tue, 27 Feb 2001 11:49:24 -0500
Received: from atapco.demon.co.uk ([194.222.134.57]:48389 "EHLO
	atapco.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129589AbRB0QtP>; Tue, 27 Feb 2001 11:49:15 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102271648.f1RGmLr08116@brick.arm.linux.org.uk>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: anton@linuxcare.com.au (Anton Blanchard)
Date: Tue, 27 Feb 2001 16:48:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010228001800.C2207@linuxcare.com> from "Anton Blanchard" at Feb 28, 2001 12:18:00 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard writes:
> > I'm seeing odd behaviour with rsync over ssh between two x86 machines -
> > one if the is an UP PIII (Katmai) running 2.4.2 (isdn-gw) and the other
> > is an UP Pentium 75-200 (pilt-gw) running 2.2.15pre13 with some custom
> > serial driver hacks (for running Amplicon cards with their ISA interrupt-
> > sharing scheme).
> 
> What version of ssh are you using? Older versions would use blocking IO
> which would result in deadlocks (and angry emails wrongly blaming rsync :)

Note that I proved that it was sitting in select(), and therefore can't be
blocking.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

