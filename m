Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUKISSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUKISSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUKISSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:18:33 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:12561 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261605AbUKISS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:18:28 -0500
Date: Tue, 9 Nov 2004 19:18:44 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: Kernel 2.6.9 & adm1021 & i2c_piix4 temperature monitoring
Message-Id: <20041109191844.112a04cb.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0411091216120.3869@p500>
References: <UfARNKk2.1099926156.4923140.khali@gcu.info>
	<Pine.LNX.4.61.0411091216120.3869@p500>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0beta2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How has it been re-worked, is the option no longer valid?

The option is still valid, but the init process is way less aggressive.
Chip isn't arbitrarily reset/reconfigured anymore, and temperature
limits are preserved. Thus what the option was trying to prevent is
probably not happening anymore in the first place.

> I believe it was along early 2.6.x and possibly 2.6.5-2.6.6 that I
> tried it without the option and the machine will shut itself off (due
> to lm-sensors/etc writing "their" values for what is too hot, forcing
> the machine to shutdown).
>
> $ sensors
> max1617-i2c-0-1a
> Adapter: SMBus PIIX4 adapter at 0850
> Board:       +45 C  (low  =   -55 C, high =  +127 C)
> CPU:         +41 C  (low  =   -55 C, high =  +110 C)
> 
> If I run without the option, the values change to something like -20 C
> to 50 or 60C, hence, when you compile a kernel it heats up and the box
> shuts itself off, with no warning at all, just powers off.

That part of the init process was actually removed in 2.6.6. Believe me,
you are not the only one to have complained about that nasty behavior.

-- 
Jean Delvare
http://khali.linux-fr.org/
