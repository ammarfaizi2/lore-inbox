Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968039AbWLEGVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968039AbWLEGVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968381AbWLEGVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:21:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44044 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968039AbWLEGVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:21:07 -0500
Date: Mon, 4 Dec 2006 22:21:03 -0800
From: "Kurtis D. Rader" <krader@us.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20061205062103.GA2604@us.ibm.com>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917074929.GD25800@htj.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 16:49:29, Tejun Heo wrote:
> Can you please try the attached patch?

I'm seeing the same problem reported by Robin Johnson: that is, the
first two SATA disks are seen by the Linux kernel but the third is not.
The third drive is seen by the BIOS.

I attempted to apply the patch posted by Tejun Heo on 2006-09-17 but it
won't apply against a 2.6.19 kernel. The patch-2.6.19-git6 diff doesn't
contain the needed changes.

Is there a patch compatible with the current source tree? The reason I
ask is that I installed a Intel DP964LT mainboard in my worksation today
(to resolve a SATA silent data corruption problem with a ASUS nVidia
nForce 4 mainboard). Should I try to adapt the patch from September for
the 2.6.19 kernel source or is there an easier option? I've already spent
nearly a week debugging the silent data corruption problem that caused me
to switch mainboards and CPUs and I'm eager to get back to my real job
of solving my customer's problems rather than mine :-)

-- 
Kurtis D. Rader, Linux level 3 support  email: krader@us.ibm.com
IBM Integrated Technology Services      DID: +1 503-578-3714
15300 SW Koll Pkwy, MS RHE2-O2          service: 800-IBM-SERV
Beaverton, OR 97006-6063                http://www.ibm.com
