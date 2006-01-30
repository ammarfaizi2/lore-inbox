Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWA3Pej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWA3Pej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWA3Pei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:34:38 -0500
Received: from pat.qlogic.com ([198.70.193.2]:62438 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S932333AbWA3Peh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:34:37 -0500
Date: Mon, 30 Jan 2006 07:34:35 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla2xxx related oops in 2.6.16-rc1
Message-ID: <20060130153435.GC1160@andrew-vasquezs-powerbook-g4-15.local>
References: <43DA580E.3020100@madness.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA580E.3020100@madness.at>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Jan 2006 15:34:37.0504 (UTC) FILETIME=[ADB00C00:01C625B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006, Stefan Kaltenbrunner wrote:

> We hit the following oops in 2.6.16-rc1 during itesting of a
> devicemapper based multipath infrastructure.
> 
> The oops happend during heavy io on the devicemapper device and a reboot
> of one of the switches the host was directly connected too.
> 
> The host in questions is as Dual Opteron 280 with 16GB ram and two
> qla2340 adapters accessing an IBM DS4300 Array.
> 
> Stefan
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
> <ffffffff803cc6c6>{_spin_lock+0}
> PGD 3ff513067 PUD 3ff514067 PMD 0
> Oops: 0002 [1] SMP
> CPU 0
> Modules linked in: dm_round_robin dm_multipath dm_mod i2c_amd756 qla2300
> qla2xxx i2c_core evdev
> Pid: 2568, comm: qla2300_1_dpc Not tainted 2.6.16-rc1 #4
> RIP: 0010:[<ffffffff803cc6c6>] <ffffffff803cc6c6>{_spin_lock+0}

Could you retry your tests with the following patchset:

http://marc.theaimsgroup.com/?l=linux-scsi&m=113779768321616&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=113779768230038&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=113779768230735&w=2

they will apply cleanly an 2.6.16-rc1 tree.

Regards,
Andrew Vasquez
