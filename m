Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbUKHMkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUKHMkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbUKHMkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:40:45 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:37973 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261824AbUKHMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:40:39 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.19
Date: Mon, 8 Nov 2004 13:42:08 +0100
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
References: <20041019180059.GA23113@elte.hu> <200411081015.47750.annabellesgarden@yahoo.de> <20041108101938.GA13628@elte.hu>
In-Reply-To: <20041108101938.GA13628@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411081342.08424.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag 08 November 2004 11:19 schrieb Ingo Molnar:
> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > RT-V0.7.19-dmesg_after_boot_rl3.log is a freshly booted dmesg output
> > after logging on via ssh. RT-V0.7.19-proc_acpi_TAB.log is captured via
> > netconsole. This log started after logging in locally, then typing in
> > "cat /proc/acpi", then first <TAB> gives an additional "/", 2nd <TAB>
> > gives no visual effect, 3rd <TAB> produces whats in the log.
> 
> could you try this with vanilla -mm3 too? The crash seems to be generic:
> 
>  [<c011ae89>] do_page_fault+0x3b7/0x64e (220)
>  [<c0107c63>] error_code+0x2b/0x30 (100)
>  [<c01991e4>] proc_lookup+0x81/0xc9 (52)
>  [<c01762e8>] real_lookup+0xb2/0xd6 (36)
>  [<c017660f>] do_lookup+0x82/0x8d (32)
>  [<c0176d8f>] link_path_walk+0x775/0x1071 (108)
>  [<c01779b2>] path_lookup+0xa5/0x1b0 (32)
>  [<c0177c5f>] __user_walk+0x30/0x4d (32)
>  [<c01720eb>] vfs_stat+0x1f/0x5a (92)
>  [<c0172784>] sys_stat64+0x1e/0x3d (100)
>  [<c0107191>] sysenter_past_esp+0x52/0x71 (-4028)

right, on -mm3 bash crashes alike on "cat /proc/acpi" + 3*<TAB>.
Sent a dmesg output to Andrew under the "2.6.10-rc1-mm3"-thread.

Thanks,
Karsten
