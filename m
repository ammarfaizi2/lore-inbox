Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131172AbRCGUYN>; Wed, 7 Mar 2001 15:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131177AbRCGUYD>; Wed, 7 Mar 2001 15:24:03 -0500
Received: from [209.102.105.34] ([209.102.105.34]:20235 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131172AbRCGUXs>;
	Wed, 7 Mar 2001 15:23:48 -0500
Date: Wed, 7 Mar 2001 12:22:22 -0800
From: Tim Wright <timw@splhi.com>
To: Ettore Perazzoli <ettore@ximian.com>
Cc: timw@splhi.com, linux-kernel@vger.kernel.org
Subject: Re: Interesting fs corruption story
Message-ID: <20010307122222.A1254@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Ettore Perazzoli <ettore@ximian.com>, timw@splhi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com> <20010306170102.B1095@kochanski.internal.splhi.com> <983927410.11517.0.camel@milkplus.unknown.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <983927410.11517.0.camel@milkplus.unknown.domain>; from ettore@ximian.com on Tue, Mar 06, 2001 at 08:10:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 08:10:10PM -0500, Ettore Perazzoli wrote:
> On 06 Mar 2001 17:01:02 -0800, Tim Wright wrote:
[...]
> > The fix for me was to rebuild the kernel and make sure CONFIG_APM_ALLOW_INTS
> > was enabled. So, do you ever use power management and is this similar, or do
> > you have a completely different problem ?
> 
>   Wow, this sounds like this might be the problem.  I just checked my
> `.config' and indeed `CONFIG_APM_ALLOW_INTS' is not enabled.  And indeed
> I have been suspending/resuming the machine a few times before the
> partition got corrupted.
> 
>   So, does DMA work correctly on your system after setting this option?

Yes, it does. I have the drive running in UDMA mode 2, and get ~16MB/s from
'hdparm -t -T'. I have the "use DMA automatically" option turned on in the
kernel, so I inherit the BIOS settings which are correct.

I've used standby and hibernation with complete success since.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
