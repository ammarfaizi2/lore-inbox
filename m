Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVLUXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVLUXfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVLUXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:35:37 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:32968 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S964992AbVLUXfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:35:36 -0500
Date: Wed, 21 Dec 2005 18:35:34 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
In-reply-to: <20051222000025.4ee54e84.khali@linux-fr.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200512211835.34309.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <200512201505.43199.gene.heskett@verizon.net>
 <200512211725.39984.gene.heskett@verizon.net>
 <20051222000025.4ee54e84.khali@linux-fr.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 18:00, Jean Delvare wrote:
>Hi Gene,
>
>> > Please keep this conversation on the LKML, where it started.
>
>How many times must I tell you?

Using reply all, it shows up in the inbox first?

And, running 2.6.15-rc6 for the third time, its all working!

And I asked for some nilmerg spray earlier, this thing has a few of 
those. :(

>> Next adapter: SMBus nForce2 adapter at 5100
>> Do you want to scan it? (YES/no/selectively):
>> Client found at address 0x08
>> Client found at address 0x4e
>> Probing for `National Semiconductor LM75'... Failed!
>> Probing for `Dallas Semiconductor DS1621'... Failed!
>> Probing for `Analog Devices ADM1021'... Failed!
>> Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
>> Probing for `Maxim MAX1617'... Failed!
>> Probing for `Maxim MAX1617A'... Failed!
>> Probing for `TI THMC10'... Failed!
>> Probing for `National Semiconductor LM84'... Failed!
>> Probing for `Genesys Logic GL523SM'... Failed!
>> Probing for `Onsemi MC1066'... Failed!
>> Probing for `Maxim MAX1619'... Failed!
>> Probing for `National Semiconductor LM82'... Failed!
>> Probing for `National Semiconductor LM83'... Failed!
>> Probing for `Maxim MAX6659'... Failed!
>> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
>
>Hmm, that could be a secondary temperature sensor. Please find out
>which i2c bus number is "SMBus nForce2 adapter at 5100" (using
>"-i2cdetect l") then dump the chips contents ("i2cdump N 0x4e b"
> where N is the i2c bus number).
Next adapter: SMBus nForce2 adapter at 5100
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Maxim MAX1619'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Maxim MAX6659'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!

[root@coyote root]# i2cdump 1 0x4e b
WARNING! This program can confuse your I2C bus, cause data loss and 
worse!
I will probe file /dev/i2c-1, address 0x4e, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 08 33 33 03 80 01 00 00 00 ff 00 00 00 00 00    .?33???.........
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

>
>Please check "lsmod" and confirm that you are using the w83627hf
> driver and not the older w83781d driver.

I am useing w83627hf

>
>> > 2* The output of "sensors" in 2.6.15-rc5.
>>
>> [root@coyote root]# sensors
>> (...)
>> w83627hf-isa-0290
>> Adapter: ISA adapter
>> VCore 1:   +1.66 V  (min =  +1.57 V, max =  +1.73 V)
>> VCore 2:   +1.79 V  (min =  +1.57 V, max =  +1.73 V)       ALARM
>> +3.3V:     +3.26 V  (min =  +3.14 V, max =  +3.47 V)
>> +5V:       +4.87 V  (min =  +4.76 V, max =  +5.24 V)
>> +12V:     +11.80 V  (min = +10.82 V, max = +13.19 V)
>> -12V:     -12.28 V  (min = -13.18 V, max = -10.80 V)
>> -5V:       -5.05 V  (min =  -5.25 V, max =  -4.75 V)
>> V5SB:      +5.59 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
>> VBat:      +3.15 V  (min =  +2.40 V, max =  +3.60 V)
>> fan1:     1757 RPM  (min =   -1 RPM, div = 16)              ALARM
>> fan2:     2636 RPM  (min =  659 RPM, div = 16)
>> fan3:        0 RPM  (min = 2636 RPM, div = 16)              ALARM
>> temp1:       -48°C  (high =    +0°C, hyst =   +11°C)   sensor =
>> thermistor
>> temp2:     +67.5°C  (high =  +120°C, hyst =  +115°C)   sensor =
>> thermistor
>> temp3:    +127.5°C  (high =  +120°C, hyst =  +115°C)   sensor =
>> PII/Celeron diode   ALARM
>> vid:      +1.650 V
>> alarms:
>> beep_enable:
>>           Sound alarm enabled
>>
>> > 3* The output of "sensors" in 2.6.15-rc6.
>>
>> (...)
>> w83627hf-isa-0290
>> Adapter: ISA adapter
>> VCore 1:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
>> VCore 2:   +1.79 V  (min =  +1.57 V, max =  +1.73 V)       ALARM
>> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
>> +5V:       +4.87 V  (min =  +4.76 V, max =  +5.24 V)
>> +12V:     +11.86 V  (min = +10.82 V, max = +13.19 V)
>> -12V:     -12.28 V  (min = -13.18 V, max = -10.80 V)
>> -5V:       -5.00 V  (min =  -5.25 V, max =  -4.75 V)
>> V5SB:      +5.62 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
>> VBat:      +3.14 V  (min =  +2.40 V, max =  +3.60 V)
>> fan1:     1721 RPM  (min =   -1 RPM, div = 16)              ALARM
>> fan2:     2636 RPM  (min =  659 RPM, div = 16)
>> fan3:        0 RPM  (min = 2636 RPM, div = 16)              ALARM
>> temp1:       -48°C  (high =    +0°C, hyst =   +11°C)   sensor =
>> thermistor
>> temp2:     +63.0°C  (high =  +120°C, hyst =  +115°C)   sensor =
>> thermistor
>> temp3:    +127.5°C  (high =  +120°C, hyst =  +115°C)   sensor =
>> PII/Celeron diode   ALARM
>> vid:      +1.650 V
>> alarms:
>> beep_enable:
>>           Sound alarm enabled
>>
>> Humm, not a heck of a lot of diff to the sensors output. temp1 is
>> shut off in gkrellm anyway.  Is temp3 the cpu?  This is an Athon
>> XP-2800 stepping 00 cpu.
>
>Obvsiouly not, else your computer would be on fire. The CPU temp
> would be temp2, although it's quite high especially for a
> thermistor-based measurement (which is usually taken from the socket
> rather than the CPU itself). And it matches what gkrellm tells you
> in -rc5 (65 degrees C is 149 degrees F).
>
>temp1 and temp3 are either nor wired, or use a different sensor type
>than the one currently setup. You may try changing the sensor type
> and see if it brings interesting readings (like built-in CPU diode
> or motherboard sensor).
>
THRM at default, and temp2, both result in only one reading, of about 
156F in gkrellm, I guess I better truck this thing out to an air hose 
& give it a litteral blow job.

>And actually there is very little difference between both outputs -
>I expected this as the driver did not change between -rc5 and -rc6.
>So the problem seems to be that gkrellm fails to pick the proper
>temperature input in -rc6. Why, I have no idea. But as long as
>"sensors" work, the bug has to be in gkrellm rather than the kernel
>driver.
>
>See if you have anything under /proc/acpi/thermal_zone. Maybe gkrellm
>picks the temperature from ACPI in -rc6 for whatever reason.

Several entries, in the THRM subdir, and tempertaure is 69C.  Youch!
Later, after I blow this thing out.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
