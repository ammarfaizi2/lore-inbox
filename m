Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTBVQha>; Sat, 22 Feb 2003 11:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbTBVQha>; Sat, 22 Feb 2003 11:37:30 -0500
Received: from horkos.telenet-ops.be ([195.130.132.45]:5524 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S266771AbTBVQh3> convert rfc822-to-8bit; Sat, 22 Feb 2003 11:37:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bdschuym@pandora.be>
To: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module loading on demand
Date: Sat, 22 Feb 2003 17:48:02 +0100
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.44.0302220835590.13234-100000@bilbo.tmr.com>
In-Reply-To: <Pine.LNX.4.44.0302220835590.13234-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302221748.02363.bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 February 2003 14:43, Bill Davidsen wrote:
> I note that with "new modules" modules no longer seem to load as needed
> but must be loaded by hand or explicitly in modprobe.conf.
> I have just been bitten by this trying to build a kernel (loop needed to
> be loaded by hand) and using a VFAT format ZIP drive partition, where
> mount didn't load the vfat module.
>
> Is there some trick to making modules useful again?

I don't know if this is your solution, but for some reason I have to do
echo "/sbin/modprobe" > /proc/sys/kernel/modprobe
to get automatic loading to work.
IIRC, this proc entry points to /bin/true by default for some reason,  for 2.5 
kernels.

-- 
cheers,
Bart

