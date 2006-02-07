Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWBGPqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWBGPqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWBGPqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:46:12 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:18603 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S965136AbWBGPqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:46:09 -0500
Message-ID: <43E8C088.1040206@cfl.rr.com>
Date: Tue, 07 Feb 2006 10:45:12 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: alex-lists-linux-kernel@yuriev.com, linux-kernel@vger.kernel.org
Subject: Re: non-fakeraid controllers
References: <20060207015126.GA12236@s2.yuriev.com> <43E85337.1090001@aitel.hist.no>
In-Reply-To: <43E85337.1090001@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2006 15:47:00.0935 (UTC) FILETIME=[BC1C9D70:01C62BFD]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14253.000
X-TM-AS-Result: No--8.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Ability to boot requires bios/bootloader support. Depending on the 
> bios in
> question, this may work for real RAID, fakeraid or even linux sw raid.
>
> You can boot directly from the software raid-1 in linux.  And you can set
> it up so it will boot with one drive failed too - although you may have
> to disconnect the bad drive so the biosdoesn't mistakenly try to load the
> kernel bootloader from the damaged disk.
>
> Having the root filesytem on a damaged array is not a problem - as soon
> as the kernel is running it can activate the raid in degraded mode and
> use the filesystem just fine.  This is no more secure than a 
> single-disk setup
> though, so don't wait too long before you replace the failed drive.
>
> Fakeraid controllers may have bios support for booting, but often
> you'll find that linux have no support for the fake raid.  So you have
> to turn that off and use software raid instead.  An expensive "real raid"
> controller that have linux support, will usually have a bios that support
> booting from the raid too.  Writing to manufacturers should get you the
> details on booting in degraded conditions.
>


Heinz wrote a utility called 'dmraid' which detects and activates 
various hardware fakeraid volumes using the kernel device mapper.  I'm 
using it at home to dual boot ubuntu and winxp ( just in case ) from a 
stripe of two WD 10,000 rpm raptors and it works great.  I'm still 
pushing to get it integrated into dapper.  At this time however, neither 
my hardware, nor dmraid support raid-5.  Hopefully this will change in 
the future. 


