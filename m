Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSAFVgw>; Sun, 6 Jan 2002 16:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSAFVgm>; Sun, 6 Jan 2002 16:36:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:525 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289039AbSAFVgg>; Sun, 6 Jan 2002 16:36:36 -0500
Date: Sun, 6 Jan 2002 21:36:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-ID: <20020106213619.C7654@flint.arm.linux.org.uk>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca> <3C38BC6B.7090301@zytor.com> <200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca> <3C38BD32.6000900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C38BD32.6000900@zytor.com>; from hpa@zytor.com on Sun, Jan 06, 2002 at 01:10:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 01:10:10PM -0800, H. Peter Anvin wrote:
> The existence of a CPU creates /dev/cpu/# and registering a node 
> replicates across the /dev/cpu directories.

And, thus, we decend into more /proc crappyness.

After *lots* of discussion and months of waiting, it was decided between
Alan, David Jones, Jeff Garzik, and other affected parties that
/proc/sys/cpu/#/whatever would be a reasonable.  It has even appeared on
lkml a couple of times in the past.

Currently, there is an allocated sysctl number in include/linux/sysctl.h
for /proc/sys/cpu, and it is used by the cpufreq code to provide:

  /proc/sys/cpu/#/speed
  /proc/sys/cpu/#/speed-max
  /proc/sys/cpu/#/speed-min

However, it's true that some of that needs to be pulled out so anything
can use /proc/sys/cpu/#.  Just takes the necessary parties to get together
to do the hard work, and with the right hardware to test it out.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

