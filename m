Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945961AbWBCVHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945961AbWBCVHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWBCVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:07:04 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:60443 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1945961AbWBCVHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:07:03 -0500
Message-ID: <43E3C5C5.5070301@cfl.rr.com>
Date: Fri, 03 Feb 2006 16:06:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <20060203180421.GA57965@dspnet.fr.eu.org> <43E3B3F3.8060107@cfl.rr.com> <20060203204712.GA84752@dspnet.fr.eu.org>
In-Reply-To: <20060203204712.GA84752@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 21:07:38.0735 (UTC) FILETIME=[DD14EFF0:01C62905]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--8.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> No, it isn't.  OTOH, udev maintains it, so I guess that's good enough.
> It makes udev the kernel interface though.  I hope they now care about
> compatibility (/dev/.udev.pdb vs. /dev/.udev/db/* anyone?).
> 

Yes, it is, where do you think udev gets it's information from?  That's 
right, from /sys.  Sysfs is the kernel interface, not udev; the 'u' in 
udev is for 'user', as in NOT part of the kernel.

>
> Bullshit.  If <x> is the only interface available to a kernel service,
> then <x> is part of the kernel whether you like it or not.  Case in
> point, the ALSA library.

Bullshit yourself.  If cdrecord is the only application for burning cds, 
that does not make it the kernel interface for cds, and certainly does 
not make it part of the kernel.  The kernel interface is the point of 
interaction between user and kernel code, which is sysfs.

Udev and HAL are two user mode ( NOT parts of the kernel ) components 
built to put the information from sysfs to use in user space, and other 
applications are encouraged to utilize the services those daemons 
provide.  By no stretch of the imagination does that make them part of 
the kernel.


