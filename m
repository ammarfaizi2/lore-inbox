Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277894AbRJISkj>; Tue, 9 Oct 2001 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277895AbRJISk3>; Tue, 9 Oct 2001 14:40:29 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:42002 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S277894AbRJISkZ>; Tue, 9 Oct 2001 14:40:25 -0400
Date: Tue, 9 Oct 2001 20:40:39 +0200
From: Kurt Roeckx <Q@ping.be>
To: Jose_Jorge@teklynx.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: kapmidled and AMD K6-2
Message-ID: <20011009204038.A6727@ping.be>
In-Reply-To: <OFD647EAB7.926A3491-ONC1256AE0.00534E9E@bradycorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFD647EAB7.926A3491-ONC1256AE0.00534E9E@bradycorp.com>; from Jose_Jorge@teklynx.fr on Tue, Oct 09, 2001 at 04:15:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 04:15:20PM +0100, Jose_Jorge@teklynx.fr wrote:
> Hi,
> 
> I have read all recent mails about this misunderstooded change in 2.4
> series. But as no one reports heating, I do :
> 
> for the AMD K6-2 on a DFI motherboard AT/ATX, using the AT power supply,
> this option is buggy. I mean the cycles kapmidled works doesn't cool the
> processor, they hot him.
> 
> This stops as soon as I uncheck the option "Send Halt command on idle" in
> the APM settings of the kernel.

I have a K6-2 too.  When I'm using 100% of the CPU, the temp of
the CPU is around 42 - 44 °C.  When I don't use any CPU at all it
will lower with about 10 °C.

>From my .config:

CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

The only reason I enable APM is because then I can do a
powerdown.

I'm willing to test if the temp goes up when I enable
CONFIG_APM_CPU_IDLE, and it's idle otherwise.
CONFIG_APM_CPU_IDLE is shown as "Make CPU Idle calls when idle",
I don't see a "Send Halt command on idle".


Kurt

