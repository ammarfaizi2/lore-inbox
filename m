Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTKBJsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTKBJsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:48:10 -0500
Received: from [62.233.185.126] ([62.233.185.126]:260 "EHLO
	aclaptop.unregistered.futuro.pl") by vger.kernel.org with ESMTP
	id S261602AbTKBJsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:48:08 -0500
From: Szymon =?iso-8859-2?q?Aceda=F1ski?= <accek@poczta.gazeta.pl>
To: ruben@puettmann.net
Subject: Re: Synaptics losing sync
Date: Sun, 2 Nov 2003 10:48:33 +0100
User-Agent: KMail/1.5
References: <N7gI.1K3.9@gated-at.bofh.it> <E1AG4NH-0006xZ-00@baloney.puettmann.net>
In-Reply-To: <E1AG4NH-0006xZ-00@baloney.puettmann.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021048.33698.accek@poczta.gazeta.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Saturday 01 November 2003 23:37, Ruben Puettmann wrote:
> > ...
> > Synaptics driver lost sync at 1st byte
> > Synaptics driver resynced.
> > Losing too many ticks!
> > TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> > Falling back to a sane timesource.
> > Synaptics driver lost sync at 1st byte
> > ...
> >

I can observe the same "Synaptics lost sync" messages on Acer TravelMate 242XC 
with ACPI enabled (without APM even compiled) on 2.6.0-test[0-9]. But I 
silently ignore these messages - touchpad works ok. I use an USB mouse, but 
messages appear even without it plugged.

"Losing too many ticks" exists when I'm running with cpufreq [p4_clockmod] and 
clock=tsc (default). This is because of rescaling TSC pitch by cpufreq, I 
think. If I specify in bootloader clock=hpet, problem disappears. [Am I doing 
right?]

I can provide more information if somebody is interested.

Cheers
Szymon
