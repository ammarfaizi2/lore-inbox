Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbTCLX0t>; Wed, 12 Mar 2003 18:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbTCLX0t>; Wed, 12 Mar 2003 18:26:49 -0500
Received: from saintmail.net ([207.54.173.29]:57554 "EHLO mail.saintmail.net")
	by vger.kernel.org with ESMTP id <S262112AbTCLX0s>;
	Wed, 12 Mar 2003 18:26:48 -0500
From: "Christopher Meredith" <theophile@saintmail.net>
Reply-to: theophile@saintmail.net
To: linux-kernel@vger.kernel.org
Subject: Re: PowerNow!, cpufreq, and swsusp
X-Mailer: Quality Web Email v3.0r, http://netwinsite.com/refw.htm
Date: Wed, 12 Mar 2003 18:37:32 -0500
Message-id: <3e6fc4bc.686d.2288@saintmail.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple question: How do I mount sysfs? Also, any idea on the
swsusp issue? Thanks!

~Christopher

On Wed, 12 Mar 2003 17:40:01 -0100
Dave Jones <davej@codemonkey.org.uk> wrote:

> On Wed, Mar 12, 2003 at 12:06:33PM -0500, Christopher
Meredith wrote:
>
>  > Also, cpufreq doesn't seem to do anything. Should it be
>  > working automatically?
>
> no.
>
>  > Even when the machine sits unattended
>  > for over 8 hours, the fan never turns off and the cpu
>  > temperature is consustently 69-70 degrees C.
>
> The kernel doesn't define policy, but exposes the
necessary
> interface to userspace.  There are a few folks working on
> tools / scripts to adjust the speed dynamically.
> look through the cpufreq mailing list archives to find
them
> (or google)
>
>  > What must I do here?
>
> Read Documentation/cpu-freq/user-guide.txt
>
> short: mount sysfs, and ..
>
> (root@evo:cpufreq)# cd /sys/class/cpu/cpufreq/cpu0/cpufreq
> (root@evo:cpufreq)# cat /proc/cpuinfo | grep MHz
> cpu MHz		: 1390.536
> (root@evo:cpufreq)# echo powersave >scaling_governor
> (root@evo:cpufreq)# cat /proc/cpuinfo | grep MHz
> cpu MHz		: 529.728
> (root@evo:cpufreq)# echo performance >scaling_governor
>
> 		Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


---------------------------------------
Use SaintMail! - http://www.saintmail.net
