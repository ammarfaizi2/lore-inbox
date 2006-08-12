Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWHLV5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWHLV5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWHLV5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:57:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32597 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932102AbWHLV5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:57:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Pluo9qu1Us62iXvKi1EpzWEtSQXl3Szoq8c3iw0kEdurkiB/MOqIzPKMepobnC68gDM1F8yz2heABPYQkbFviybBGNaKDFRbB6Vi219deWaMs65+CIH/HTVktRvzqh5Uc1uFtwKkDaEY7q0n0wPgu+Sej04InUODDDPXLVbzjvA=
Message-ID: <44DE4EC8.8090404@gmail.com>
Date: Sat, 12 Aug 2006 23:57:05 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jani Aho <jani.aho@bonetmail.com>
CC: linux-kernel@vger.kernel.org, stable@kernel.org, i2c@lm-sensors.org
Subject: Re: Sensors broke between 2.6.16.16 and 2.6.16.17
References: <44DE0DCE.4090305@bonetmail.com>
In-Reply-To: <44DE0DCE.4090305@bonetmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Aho wrote:
> Hi
> 
> The sensors on my motherboard stopped working between 2.6.16.16 and
> 2.6.16.17. The latest kernel version I have tried is 2.6.17.8 and it
> still has the same problem.
> 
> The motherboard is an ASUS P4PE and it uses the asb100 and i2c-i801
> modules to get sensor information.
> 
> A diff in /sys between a bad (2.6.17.8) and a good (2.6.16.16) kernel gives:

And is there any diff in dmesgs of those 2 kernels?

> --- i2c.bad     2006-08-12 18:42:57.000000000 +0200
> +++ i2c.good    2006-08-12 18:50:44.000000000 +0200
> @@ -37,9 +37,15 @@
>  /sys/module/i2c_core/sections/.text
>  /sys/module/i2c_core/refcnt
>  /sys/class/i2c-adapter
> +/sys/class/i2c-adapter/i2c-0
> +/sys/class/i2c-adapter/i2c-0/device
> +/sys/class/i2c-adapter/i2c-0/uevent
>  /sys/bus/i2c
>  /sys/bus/i2c/drivers
>  /sys/bus/i2c/drivers/asb100
> +/sys/bus/i2c/drivers/asb100/0-0048
> +/sys/bus/i2c/drivers/asb100/0-0049
> +/sys/bus/i2c/drivers/asb100/0-002d
>  /sys/bus/i2c/drivers/asb100/bind
>  /sys/bus/i2c/drivers/asb100/unbind
>  /sys/bus/i2c/drivers/asb100/module
> @@ -48,3 +54,85 @@
>  /sys/bus/i2c/drivers/i2c_adapter/unbind
>  /sys/bus/i2c/drivers/i2c_adapter/module
>  /sys/bus/i2c/devices
> +/sys/bus/i2c/devices/0-0048
> +/sys/bus/i2c/devices/0-0049
> +/sys/bus/i2c/devices/0-002d
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/name
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/bus
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/driver
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/power
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/power/wakeup
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/power/state
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0048/uevent
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/name
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/bus
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/driver
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/power
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/power/wakeup
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/power/state
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-0049/uevent
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/pwm1_enable
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/pwm1
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/alarms
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/vrm
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/cpu0_vid
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp4_max_hyst
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp4_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp4_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp3_max_hyst
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp3_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp3_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp2_max_hyst
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp2_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp2_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp1_max_hyst
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp1_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/temp1_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan3_div
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan3_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan3_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan2_div
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan2_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan2_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan1_div
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan1_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/fan1_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in6_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in6_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in6_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in5_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in5_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in5_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in4_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in4_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in4_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in3_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in3_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in3_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in2_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in2_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in2_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in1_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in1_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in1_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in0_max
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in0_min
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/in0_input
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/hwmon:hwmon0
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/name
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/bus
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/driver
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/power
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/power/wakeup
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/power/state
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/uevent
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/i2c-adapter:i2c-0
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/name
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power/wakeup
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power/state
> +/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/uevent
> 
> I run an updated Debian Sid distro.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
