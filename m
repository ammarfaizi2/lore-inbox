Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVAUQZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVAUQZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVAUQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:25:18 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:41624 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262415AbVAUQYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:24:41 -0500
Message-ID: <41F12C94.4030808@kolivas.org>
Date: Sat, 22 Jan 2005 03:23:48 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
         scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>    <873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>    <87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>    <87oefkd7ew.fsf@sulphur.joq.us>    <10752.195.245.190.93.1106211979.squirrel@195.245.190.93>    <65352.195.245.190.94.1106240981.squirrel@195.245.190.94>    <874qhb99rv.fsf@sulphur.joq.us> <1728.195.245.190.93.1106299090.squirrel@195.245.190.93>
In-Reply-To: <1728.195.245.190.93.1106299090.squirrel@195.245.190.93>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6ED8CABDE729889A0F65A6A2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6ED8CABDE729889A0F65A6A2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rui Nuno Capela wrote:
> Jack O'Quin wrote:
> 
>>[...] Looking at the graph, it appears that your DSP load is hovering
>>above 70% most of the time.  This happens to be the default threshold
>>for revoking realtime privileges.  Perhaps that is the problem.  Try
>>running it with the threshold set to 90%.  (I don't recall exactly
>>how, but I think there's a /proc/sys/kernel control somewhere.)
>>
> 
> 
> It would be nice to know which one really is :) Here are what I have here:
> 
> # grep . /proc/sys/kernel
> /proc/sys/kernel/bootloader_type:2
> /proc/sys/kernel/cad_pid:1
> /proc/sys/kernel/cap-bound:-257
> /proc/sys/kernel/core_pattern:core
> /proc/sys/kernel/core_uses_pid:1
> /proc/sys/kernel/ctrl-alt-del:0
> /proc/sys/kernel/debug_direct_keyboard:0
> /proc/sys/kernel/domainname:(none)
> /proc/sys/kernel/hostname:lambda
> /proc/sys/kernel/hotplug:/sbin/hotplug
> /proc/sys/kernel/kernel_preemption:1
> /proc/sys/kernel/modprobe:/sbin/modprobe
> /proc/sys/kernel/msgmax:8192
> /proc/sys/kernel/msgmnb:16384
> /proc/sys/kernel/msgmni:16
> /proc/sys/kernel/ngroups_max:65536
> /proc/sys/kernel/osrelease:2.6.11-rc1-RT-V0.7.35-01.0
> /proc/sys/kernel/ostype:Linux
> /proc/sys/kernel/overflowgid:65534
> /proc/sys/kernel/overflowuid:65534
> /proc/sys/kernel/panic:0
> /proc/sys/kernel/panic_on_oops:0
> /proc/sys/kernel/pid_max:32768
> /proc/sys/kernel/printk:3	4	1	7
> /proc/sys/kernel/printk_ratelimit:5
> /proc/sys/kernel/printk_ratelimit_burst:10
> /proc/sys/kernel/prof_pid:-1
> /proc/sys/kernel/sem:250	32000	32	128
> /proc/sys/kernel/shmall:2097152
> /proc/sys/kernel/shmmax:33554432
> /proc/sys/kernel/shmmni:4096
> /proc/sys/kernel/sysrq:1
> /proc/sys/kernel/tainted:0
> /proc/sys/kernel/threads-max:8055
> /proc/sys/kernel/unknown_nmi_panic:0
> /proc/sys/kernel/version:#1 Mon Jan 17 15:15:21 WET 2005
> 
> My eyes can't find anything related, but you know how intuitive these
> things are ;)

He means when using the SCHED_ISO patch. Then you'd have iso_cpu and 
iso_period, which you have neither of so you are not using SCHED_ISO.

Cheers,
Con

--------------enig6ED8CABDE729889A0F65A6A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8SyWZUg7+tp6mRURAitlAJ9C+8yz9cjXFL+JbgD04Kaa42YP1QCeJZ+4
uiFkGJ0qatAl+rT7RrjNHPk=
=zaGg
-----END PGP SIGNATURE-----

--------------enig6ED8CABDE729889A0F65A6A2--
