Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312151AbSCUQfZ>; Thu, 21 Mar 2002 11:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312140AbSCUQen>; Thu, 21 Mar 2002 11:34:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54794 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311871AbSCUQeh>; Thu, 21 Mar 2002 11:34:37 -0500
Subject: Re: NatSemi SC1200 timer problems
To: wingel@acolyte.hack.org (Christer Weinigel)
Date: Thu, 21 Mar 2002 16:50:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        miura@da-cha.org (Hiroshi MIURA), anders.wallin@mvista.com
In-Reply-To: <20020321162312.7241DF5B@acolyte.hack.org> from "Christer Weinigel" at Mar 21, 2002 05:23:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o5m2-0005fx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, i think did a patch to disable the TSC on the MediaGX and I have
> seen posts by you where you say about the MediaGX that "It reports a
> TSC but the TSC is unreliable at least in certain strange
> circumstances".  Do you refer to the TSC being stopped or turned off
> on halt or suspend or is it a completely different problem?  Could you
> please tell me what kind of problems you saw?

On the 5510/5520 bugs in the timers prevent use getting the TSC/delay
calibrated. This works ok on the 5530. I also saw some really bizarre goings
on with the TSC on some devices like joystick.

The older kernels kill TSC on any MediaGX (but will miss newer geodes due
to the cpuid change). Current one will kill tsc on 5510/5520 and knows
the new geode idents

