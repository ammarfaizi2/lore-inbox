Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUAaNKO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 08:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUAaNKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 08:10:14 -0500
Received: from 207-245-76-132.unityhill.com ([207.245.76.132]:5059 "EHLO
	mail.newearth.org") by vger.kernel.org with ESMTP id S264563AbUAaNKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 08:10:10 -0500
Date: Sat, 31 Jan 2004 08:10:02 -0500 (EST)
From: "Michael V. David" <michael@mvdavid.com>
To: linux-kernel@vger.kernel.org
cc: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
       michael@mvdavid.com
Subject: Re: raid6 badness
In-Reply-To: <401B421F.4060104@zytor.com>
Message-ID: <Pine.LNX.4.58.0401310746320.9667@sapphire.newearth.org>
References: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org.suse.lists.linux.kernel>
 <bvf2vl$6pr$1@terminus.zytor.com.suse.lists.linux.kernel> <p73ad44n7ig.fsf@verdi.suse.de>
 <401B421F.4060104@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, H. Peter Anvin wrote:
> I'll send in the attached patch for now, but at some point I'd like
> to fix this.  Unfortunately I still don't have an x86-64 machine
> that I can actually compile and install kernels on; I only have
> access to an x86-64 userspace, so I'm a bit limited in what I can
> test.
>
> Michael: Perhaps you could apply this patch and test it out for me?

Done.

The patch applied, and the module raid6.ko compiled, with no problem.

The machine was rebooted because the crashed raid6.ko would not
unload.

The new raid6.ko loaded and unloaded repeatedly without a problem.

I created a raid6 device with 6 components, and a file system, and it
worked as expected, allowing failure of 1 or 2 component devices, but
not 3.

At present, I have not tried building it into the kernel, and have not
done any hard testing of raid6.

--mvd

