Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSA0JXi>; Sun, 27 Jan 2002 04:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSA0JX2>; Sun, 27 Jan 2002 04:23:28 -0500
Received: from lilly.ping.de ([62.72.90.2]:10 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S287894AbSA0JXQ>;
	Sun, 27 Jan 2002 04:23:16 -0500
Date: 27 Jan 2002 10:22:51 +0100
Message-ID: <20020127092251.GA1885@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Thomas Hood" <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apm: busy: Unable to enter requested state
In-Reply-To: <1012006933.2576.19.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012006933.2576.19.camel@thanatos>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 08:02:13PM -0500, Thomas Hood wrote:
> > apm: setting state busy
> > apm: busy: Unable to enter requested state
> > apm: setting state busy
> > apm: busy: Unable to enter requested state
> 
> While the suspend request is being processed, the apm
> driver attempts to set the power state to "busy", as
> required by the APM spec.  The attempt fails, presumably
> because of shortcomings in your firmware.

Firmware == bios?

> Is there a driver or userland process that is failing
> to process the suspend event quickly?

None that I know of ... But the system does kind of suspend
(hdd is spun down, monitor shuts down, ....) but when the system
resumes (press key, move mouse) the temperature of the cpu is
still the same it was before the suspend. Sometime ago the
cpu cooled down to roomtemperature (sys temp also). But this
does not happen any more :-(

> > apm: received normal resume notify
> 
> The APM firmware appears to generate this event.
> Perhaps it is timing out waiting for the OS to respond
> to the suspend event with a set-power-state operation.
> How long does it take for this to happen?

When I press the suspend button the message appears
almost instantly (message appears several times). But
I checked 2.4.18-pre7 and there the message does not
appear but the cpu does not cool down either. The kernel
that generates this message was 2.4.17-rmap12a.

> > and then the cpu does not cool down (I guess it is
> > not shut down like it was before).
> 
> A suspended machine does more than cool down.  It does
> not operate at all.

That is exactly what I would like it to do and which it
partly does. But the cpu does not cool down (it seems as
if it is not shut down - do I have to use a config option
for this?).

CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

Do I have to enable one of these?

Regards,

   Jogi


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
