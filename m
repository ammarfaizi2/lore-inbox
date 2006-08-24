Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWHXOju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHXOju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWHXOju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:39:50 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:56010 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932094AbWHXOjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:39:49 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Tomasz Torcz <zdzichu@irc.pl>
Date: Thu, 24 Aug 2006 16:39:20 +0200
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-26357
Subject: Re: unexpected kernel messages for Sun Fire X4100 (NUMA Opteron 64bit) with SLES10
Cc: linux-kernel@vger.kernel.org
Message-ID: <44EDD63A.12460.BB09F92@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <20060823143553.GA2212@irc.pl>
References: <44EC7AC0.12128.6635514@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.06.0+V=4.06+U=2.07.138+R=05 June 2006+T=125846@20060824.143750Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-26357
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

On 23 Aug 2006 at 16:35, Tomasz Torcz wrote:

[...]
>   Are you sure you have latest BIOS installed? From
> http://www.sun.com/download/products.xml?id=44cfd445 :
>  BIOS 34 (0ABGA034). The improvements are:
>     (...)
>     * AMD PowerNow support

So I've installed this BIOS, realizing that it has a few new settings. Revalidated 
BIOS settings, and comparing kernel messages:

There's a new message:
<6>ACPI: SLIT table looks invalid. Not used.

Most other problems are still there, but the PowerNow seems solved:
kernel: powernow-k8: Found 4 AMD Athlon 64 / Opteron processors (version 1.60.2)
kernel: powernow-k8:    0 : fid 0x12 (2600 MHz), vid 0x8 (1350 mV)
kernel: powernow-k8:    1 : fid 0x10 (2400 MHz), vid 0xa (1300 mV)
kernel: powernow-k8:    2 : fid 0xe (2200 MHz), vid 0xc (1250 mV)
kernel: powernow-k8:    3 : fid 0xc (2000 MHz), vid 0xe (1200 mV)
kernel: powernow-k8:    4 : fid 0xa (1800 MHz), vid 0x10 (1150 mV)
kernel: powernow-k8:    5 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
kernel: cpu_init done, current fid 0x12, vid 0x8
kernel: powernow-k8:    0 : fid 0x12 (2600 MHz), vid 0x8 (1350 mV)
kernel: powernow-k8:    1 : fid 0x10 (2400 MHz), vid 0xa (1300 mV)
kernel: powernow-k8:    2 : fid 0xe (2200 MHz), vid 0xc (1250 mV)
kernel: powernow-k8:    3 : fid 0xc (2000 MHz), vid 0xe (1200 mV)
kernel: powernow-k8:    4 : fid 0xa (1800 MHz), vid 0x10 (1150 mV)
kernel: powernow-k8:    5 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
kernel: cpu_init done, current fid 0x12, vid 0x8

(There is a remaining problem with the system load ("uptime") being too high (>1) 
even if the system is doing nothing. See Screenshot (8kB).

Regards,
Ulrich


--Message-Boundary-26357
Content-type: Application/Octet-stream; name="SLES10-load.png"; type=Unknown
Content-disposition: attachment; filename="SLES10-load.png"
Content-transfer-encoding: BASE64

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
CYOaOP8fathDfJ1o2RIAAAAASUVORK5CYII=

--Message-Boundary-26357--
