Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283607AbRK3NOs>; Fri, 30 Nov 2001 08:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283608AbRK3NOi>; Fri, 30 Nov 2001 08:14:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54031 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283607AbRK3NO3>; Fri, 30 Nov 2001 08:14:29 -0500
Subject: Re: kapm-idled no longer idling CPU?
To: ast@domdv.de (Andreas Steinmetz)
Date: Fri, 30 Nov 2001 13:23:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        dglidden@illusionary.com ((Derek Glidden))
In-Reply-To: <XFMail.20011130133403.ast@domdv.de> from "Andreas Steinmetz" at Nov 30, 2001 01:34:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169ndI-0003WU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> system_idle itself just checks, if nr_running is 1. This means that if any
> single other process is runnable every HZ time when apm_idled checks the system
> state it won't switch to idle state even if the system is otherwise idle. I do
> see this behaviour e.g. all the time with KDE.

Uggh - yes, that makes horrible sense. Does it behave any better if you
check say load average for the past 15 seconds < .1 ?
