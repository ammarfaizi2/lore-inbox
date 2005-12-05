Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVLEQ3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVLEQ3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLEQ3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:29:06 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:5641 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932454AbVLEQ3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:29:05 -0500
Message-ID: <43946ACE.9040405@argo.co.il>
Date: Mon, 05 Dec 2005 18:29:02 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com>
In-Reply-To: <20051205011611.GA12664@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2005 16:29:03.0660 (UTC) FILETIME=[0155E6C0:01C5F9B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>I can't think of a single valid reason why a program would want
>to know the MHz rating of a CPU. Given that it's a) approximate,
>b) subject to change due to power management, c) completely nonsensical
>across CPU vendors, and d) only one of many variables regarding CPU
>performance, any program that bases any decision on the values found
>by parsing that field of /proc/cpuinfo is utterly broken beyond belief.
>  
>
Sometimes you need extremely low overhead time measurements, which need 
not be too accurate. One way to do this is to dump rdtsc measurements 
into some array, and later scale it using the cpu frequency.

I've done exactly this. The processes were pinned to their processors, 
and there was no frequency scaling in effect. It worked very well.
