Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbUKHJee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbUKHJee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUKHJdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:33:38 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:34703 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261811AbUKHJOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:14:25 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.19
Date: Mon, 8 Nov 2004 10:15:47 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>
References: <20041019180059.GA23113@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
In-Reply-To: <20041108091619.GA9897@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DlzjBSZYYn6pEZm"
Message-Id: <200411081015.47750.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_DlzjBSZYYn6pEZm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag 08 November 2004 10:16 schrieb Ingo Molnar:
> 
> i have released the -V0.7.19 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release includes fixes only.
> 
> Changes since -V0.7.18:
> 
>  - fixed a merge bug introduced in -V0.7.18, breaking bit-spinlocks used
>    by ext3's journalling code. This could/should fix the kjournald crash
>    reported by Adam Heath, Gunther Persoons and Eran Mann. Bug triggered
>    on !SMP kernels only.
> 
>  - added upstream patch to fix a crash in bttv/btcx_riscmem_free(), 
>    reported by Shane Shrybman.
> 
>  - made modlist_lock raw again - this could fix the /proc/acpi related
>    asserts reported by Karsten Wiese.

Doesn't. Please see attached logs.

RT-V0.7.19-dmesg_after_boot_rl3.log is a freshly booted dmesg output after logging on via ssh.
RT-V0.7.19-proc_acpi_TAB.log is captured via netconsole. This log started after logging in locally,
then typing in "cat /proc/acpi", then first <TAB> gives an additional "/", 2nd <TAB> gives no visual effect, 3rd <TAB> produces whats in the log.

thanks,
Karsten

--Boundary-00=_DlzjBSZYYn6pEZm
Content-Type: application/x-bzip2;
  name="RT-V0.7.19-dmesg_after_boot_rl3.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="RT-V0.7.19-dmesg_after_boot_rl3.log.bz2"

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
kTl2In/4u5IpwoSELkVhQA==

--Boundary-00=_DlzjBSZYYn6pEZm
Content-Type: application/x-bzip2;
  name="RT-V0.7.19-proc_acpi_TAB.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="RT-V0.7.19-proc_acpi_TAB.log.bz2"

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
lWCPFIbiD/8XckU4UJBjQgUe

--Boundary-00=_DlzjBSZYYn6pEZm--
