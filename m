Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUAFQsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUAFQsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:48:32 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:275 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id S262050AbUAFQsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:48:30 -0500
Date: Tue, 06 Jan 2004 09:48:15 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: martin f krafft <madduck@madduck.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem booting aic7xxx-old with reiserfs
Message-ID: <2263062704.1073407695@aslan.scsiguy.com>
In-Reply-To: <20040106093926.GA5904@piper.madduck.net>
References: <1aMb6-3Fs-37@gated-at.bofh.it> <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at>
 <20040106084728.GA3094@piper.madduck.net> <20040106093926.GA5904@piper.madduck.net>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried the new driver again, and there were no thousand lines.
> However, I did get error messages:
> 
>   scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
>           <Adaptec 2940 Ultra SCSI adapter>
>           aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
> 
>   scsi0:A:0:0: DV failed to configure device.  Please file a bug report
>   against this driver.

This means that Domain Validation was unable to probe the your Quantum
Fireball correctly.  For me to understand why, you need to compile
the driver with debugging enabled and the debug mask set to 0x3F.
Both of these settings can be performed via the standard kernel
configuration tools.  Just boot with those settings and send me the
complete boot output.  You may need to increase the size of your dmesg
buffer for all of the output to be recorded.

--
Justin

