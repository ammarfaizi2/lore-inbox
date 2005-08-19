Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVHSPi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVHSPi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVHSPi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:38:26 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:22783 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S1751165AbVHSPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:38:26 -0400
Message-ID: <4305FCF1.6020905@pantasys.com>
Date: Fri, 19 Aug 2005 08:38:25 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel>	 <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap>	 <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap>
In-Reply-To: <1124410753.14825.32.camel@home-lap>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 15:38:11.0390 (UTC) FILETIME=[016D75E0:01C5A4D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Sean Bruno wrote:
> Well, I do have IOMMU enabled in my kernel .config.  I have attached it
> to this message as well.  I would appreciate any guidance as I pretty
> much have no idea what 99% of the items in here are for.  This is
> the .config that I used to build the kernel from the dmesg output that
> is attached to this email.

the error that you see is because you haven't set a big enough size in 
the BIOS for the IOMMU. The error message is just saying that the kernel 
is enabling the IOMMU anyway. It used to be that it would enable 64MB, 
it looks like it's defaulting now to 256MB. When you enable a big enough 
size in the bios this error will go away (assuming that your bios fills 
in the registers correctly).

peter
