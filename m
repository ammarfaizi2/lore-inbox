Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWCHJll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWCHJll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWCHJlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:41:40 -0500
Received: from [213.91.10.50] ([213.91.10.50]:26580 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S932535AbWCHJlj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:41:39 -0500
Date: Wed, 8 Mar 2006 10:37:01 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5: unreasonable temperature reported by w83627thf-isa-0290
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <efMtccbx.1141810621.3836770.khali@localhost>
In-Reply-To: <440B1DF8.7050108@t-online.de>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Harald Dunkel" <harald.dunkel@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Wed, 08 Mar 2006 10:37:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo Harald,

On 2006-03-07, Harald Dunkel wrote:
> Configuring a barebone (Aopen MZ915-M) I tried the sensors stuff
> today. After running sensors-detect this is what sensors reports:
>
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.36 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
> +12V:     +12.28 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +3.18 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
> V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +3.10 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min =  664 RPM, div = 8)              ALARM
> CPU Fan:     0 RPM  (min =  664 RPM, div = 8)              ALARM
> fan3:        0 RPM  (min =  664 RPM, div = 8)              ALARM
> M/B Temp:     +7 C  (high =   +45 C, hyst =  +101 C)   sensor = diode
> CPU Temp:   -5.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
> temp3:      +7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
> alarms:
> beep_enable:
>           Sound alarm enabled
>
> The voltage values seem to be the same as the bios displays.
> The min/max values of VCore doesn't seem right to me.

You can just change these values to something more suitable. Edit
/etc/sensors.conf, seek to the w83627thf-* section, edit the "set
in0_min" and "set in0_max" lines.

> M/B and CPU temperatures are unreasonable. Not to mention
> the CPU fan. It is set to full speed in the bios.

Does the BIOS report any speed for that fan? If so, what is the value?

The temperature values are admittedly strange. What temperature values
does the BIOS report, if any?

> Any ideas? Any help would be highly appreciated.

Either your W83627THF chip needs some additional configuration (such as a
different thermal sensor type selection), or you have another chip on
the board handling fans and tempeartures.

Please provide the full output of sensors-detect. Also, let us know which
version of lm_sensors you are using (sensors -v).

Note that you may want to follow-up on this on the lm-sensors list [1]
rather than the LKML, which isn't really the place for user-space
configuration issues.

[1] http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--
Jean Delvare
