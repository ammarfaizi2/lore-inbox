Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWGMWVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWGMWVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWGMWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:21:38 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:38627 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1160999AbWGMWVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:21:38 -0400
To: George Nychis <gnychis@cmu.edu>
CC: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org> <44B64F57.4060407@cmu.edu> <44B66740.2040706@goop.org> <44B66740.2040706@goop.org> <44B6A9CA.8040808@cmu.edu>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Date: Thu, 13 Jul 2006 23:21:33 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1G19Yr-0004Ky-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have S3 suspend/resume working here on a TP T60.  Many caveats:

* I'm using Ubuntu's 2.6.15-25-386 kernel.
* it's a UP kernel so I'm not using the second core
* I had to tell it to unload and load ipw3945 (or else that module
  became useless).
* I had to tell acpid to trigger /etc/acpi/sleep.sh (it was running
  sleepbtn.sh) when fn-F4 was pressed, or just run sleep.sh directly.

Ubuntu's kernel probably has a bunch of patches to make SATA/AHCI work
and who knows what else.  But it means that the DSDT etc. are at least
half decent (not always true with my earlier thinkpads).

I'm hoping that some debugging will get SMP suspend/resume working as
well.  So far though I've not had any luck getting a 2.6.18-rc1 SMP
kernel to suspend (never mind resume).  I did have to enable
hotpluggable CPU's to get past the 'write error' when echoing 'mem' to
/sys/power/state.  Then I get lockdep errors and a failure to stop
tasks, which I reported to lkml and linux-acpi a few days ago.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
