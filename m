Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTKKRXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTKKRXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:23:13 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:50357
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263639AbTKKRXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:23:08 -0500
Message-ID: <3FB11B93.60701@reactivated.net>
Date: Tue, 11 Nov 2003 17:25:39 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031018 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm2
References: <20031104225544.0773904f.akpm@osdl.org>
In-Reply-To: <20031104225544.0773904f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting a couple of audio skips with 2.6.0-test9-mm2. Haven't heard a 
skip since test4 or so, so I'm assuming this is a result of the IO scheduler tweaks.

Here's how I can produce a skip:
Running X, general usage (e.g. couple of xterms, an emacs, maybe a 
mozilla-thunderbird)
I switch to the first virtual console with Ctrl+Alt+F1. I then switch back to X 
with Alt+F7. As X is redrawing the screen, the audio skips once.
This happens most of the time, but its easier to reproduce when i am compiling 
something, and also when I cycle through the virtual consoles before switching 
back to X.

System:
AMD XP2600+
nForce2 motherboard
512MB RAM
nvidia GeForce4 Ti4800

Audio being played through the intel8x0 alsa module.
I use the nvidia binary graphics driver with X.

XMMS 1.2.8
XFree 4.3.0

If theres any other info I can give, please tell me and I'll do my best to help out.

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm2/
> 
> 
> - Various random fixes.  Maybe about half of these are 2.6.0-worthy.
> 
> - Some improvements to the anticipatory IO scheduler and more readahead
>   tweaks should help some of those database benchmarks.
> 
>   The anticipatory scheduler is still a bit behind the deadline scheduler
>   in these random seeky loads - it most likely always will be.
> 
> - "A new driver for the ethernet interface of the NVIDIA nForce chipset,
>   licensed under GPL."
> 
>   Testing of this would be appreciated.  Send any reports to linux-kernel
>   or netdev@oss.sgi.com and Manfred will scoop them up, thanks.
> 
> 
> - I shall be offline for a couple of days.

