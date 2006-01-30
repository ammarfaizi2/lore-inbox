Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWA3UY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWA3UY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWA3UY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:24:28 -0500
Received: from ns1.suse.de ([195.135.220.2]:30603 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964948AbWA3UY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:24:28 -0500
Date: Mon, 30 Jan 2006 21:24:18 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Stefan Kaltenbrunner <mm-mailinglist@madness.at>,
       linux-kernel@vger.kernel.org
Subject: Re: qla2xxx related oops in 2.6.16-rc1
Message-ID: <20060130202418.GA12315@suse.de>
References: <43DA580E.3020100@madness.at> <20060130153435.GC1160@andrew-vasquezs-powerbook-g4-15.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060130153435.GC1160@andrew-vasquezs-powerbook-g4-15.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 30, Andrew Vasquez wrote:

> On Fri, 27 Jan 2006, Stefan Kaltenbrunner wrote:
> 
> > We hit the following oops in 2.6.16-rc1 during itesting of a
> > devicemapper based multipath infrastructure.
> > 
> > The oops happend during heavy io on the devicemapper device and a reboot
> > of one of the switches the host was directly connected too.
> > 
> > The host in questions is as Dual Opteron 280 with 16GB ram and two
> > qla2340 adapters accessing an IBM DS4300 Array.
> > 
> > Stefan
> > 
> > Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
> > <ffffffff803cc6c6>{_spin_lock+0}
> > PGD 3ff513067 PUD 3ff514067 PMD 0
> > Oops: 0002 [1] SMP
> > CPU 0
> > Modules linked in: dm_round_robin dm_multipath dm_mod i2c_amd756 qla2300
> > qla2xxx i2c_core evdev
> > Pid: 2568, comm: qla2300_1_dpc Not tainted 2.6.16-rc1 #4
> > RIP: 0010:[<ffffffff803cc6c6>] <ffffffff803cc6c6>{_spin_lock+0}
> 
> Could you retry your tests with the following patchset:

This is a generic bug. I hit it as well several times during my testing of
https://bugzilla.novell.com/show_bug.cgi?id=145459

If my slab corruption and this one is the same cause, no idea.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
