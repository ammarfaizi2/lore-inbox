Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWDDIFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWDDIFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWDDIFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:05:40 -0400
Received: from mail.charite.de ([160.45.207.131]:38805 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751838AbWDDIFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:05:39 -0400
Date: Tue, 4 Apr 2006 10:05:29 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060404080529.GM7849@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060404080205.C8B29E007A12@knarzkiste.dyndns.org> <20060403180207.E849EE007A12@knarzkiste.dyndns.org> <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060403190915.GA10584@charite.de> <20060403202539.65cf6e33.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060404080205.C8B29E007A12@knarzkiste.dyndns.org> <20060403202539.65cf6e33.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:

> In acpi_processor_unregister_performance(), pr->performance is NULL.
> 
> Can you add the below?  It should tell us who forgot to register the
> performance data, as well as working around the crash.

I added the patch.
in dmesg I now get:

> Apr  4 09:54:06 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> Apr  4 09:54:06 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> Apr  4 09:54:06 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> Apr  4 09:54:06 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x2
> Apr  4 09:54:06 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8

> Apr  4 09:54:25 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> Apr  4 09:54:25 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> Apr  4 09:54:25 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> Apr  4 09:54:25 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x4

> Apr  4 09:54:44 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> Apr  4 09:54:45 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> Apr  4 09:54:45 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> Apr  4 09:54:45 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x4

So, no more EIPs, but no conclusive messages either!


-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
