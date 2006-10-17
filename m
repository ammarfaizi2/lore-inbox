Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWJQHFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWJQHFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 03:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWJQHFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 03:05:07 -0400
Received: from poczta.o2.pl ([193.17.41.142]:60076 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932177AbWJQHFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 03:05:06 -0400
Date: Tue, 17 Oct 2006 09:10:05 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: David Johnson <dj@david-web.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: Hardware bug or kernel bug?
Message-ID: <20061017071005.GA1742@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	David Johnson <dj@david-web.co.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20061013085605.GA1690@ff.dom.local> <200610131724.40631.dj@david-web.co.uk> <20061016102500.GA1709@ff.dom.local> <200610161532.38663.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610161532.38663.dj@david-web.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 03:32:38PM +0100, David Johnson wrote:
...
> I've found the culprit - CPU Frequency Scaling.
> With it enabled I get the reboots, with it disabled I don't. That's the same 
> with every kernel version I've tried (2.6.19-rc1+rc2, 2.6.17.13 & Centos' 
> 2.6.9) The system was using the p4-clockmod driver and the ondemand governor.
> 
> I'm still not sure exactly what the problem is - the reboots only happen in 
> the circumstances I've mentioned and are not triggered by changes in clock 
> speed alone - but disabling cpufreq seems to make it go away...

I see you devoted a lot of work and time to this testing
and for sure it will help people who read this to
diagnose similar problems but I think it could be even
more valuable if you'd try (after some rest!) to find
if "Enable CPUfreq debugging" plus adding to kernel
command line cpufreq.debug=<value> (according to help
screen) would return any error messages that could be
send to bugzilla and/or cpufreq maintainer. 

Best regards,

Jarek P.
