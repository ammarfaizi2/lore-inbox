Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUC1UYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUC1UYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:24:45 -0500
Received: from lpbproductions.com ([68.98.208.147]:55977 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S262450AbUC1UYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:24:36 -0500
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
Date: Sun, 28 Mar 2004 13:24:51 -0700
User-Agent: KMail/1.5.94
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
In-Reply-To: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
Cc: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403281324.51318.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried the -mm tree yet ? 

If not you should. 

Matt

On Sunday 28 March 2004 1:02 pm, Andreas Hartmann wrote:
> Hello!
>
> I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
> kernel 2.6 seems to be slower than 2.4.25.
>
> So I did some tests to compare the performance directly. Therefore I
> rebooted for everey test in init 2 (no X).
>
> I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
> reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
> the following result:
>
> In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
> under 2.4.25.
> The user-processortime is about the same, but the system-processortime is
> under 2.6.4 32.9% higher than under 2.4.25.
>
>
> Now, I switched off preemption. But the performance isn't much better:
> 8.8% (9.3% with preemption) more real-time compared to 2.4.25 and 28%
> (32.9% with preepmtion) more system-time.
>
>
>
> Does anybody know, how to get the same performance under 2.6.4 (or even
> better) as under 2.4.25?
>
>
> My hardware:
> AMD Athlon(tm) XP 2000+
>
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333
> AGP] 00:09.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
> 10/100 Ethernet (rev 02)
> 00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 0c) 00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235
> AC97 Audio Controller (rev 50)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO
> AGP 4x TMDS
>
>
> Regards,
> Andreas Hartmann
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
