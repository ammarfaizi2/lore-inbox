Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUD1Oxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUD1Oxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUD1OxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:53:18 -0400
Received: from fmr03.intel.com ([143.183.121.5]:32169 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264818AbUD1OxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:53:09 -0400
Date: Wed, 28 Apr 2004 07:52:55 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: ia64-cpu-hotplug-cpu_present.patch?
Message-ID: <20040428075255.A8859@unix-os.sc.intel.com>
References: <20040427225741.2fe78d88.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040427225741.2fe78d88.pj@sgi.com>; from pj@sgi.com on Tue, Apr 27, 2004 at 10:57:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 10:57:41PM -0700, Paul Jackson wrote:

Hi Paul,

sorry for the trouble. I will try to address them, and will try to resolve the compile problem
you are having.

> I cannot find any mention of it on lkml or any other email list that
> either Google or I track.
> 
> Is there some backdoor path to Andrew's patch directory I don't know of ;)?

I sent the patch to linux-ia64, but forgot to copy lkml. No... i did not buy crispy
cream for andrew.. although that did cross my mine :-)

Some of the points you raise, i will look into, but here is a quick summary fo Paul's top 10
list!.

cpu_present is required so that when cpu_up is called in smp_init() we dont call for all
possible cpu's but just for cpu's physically present. 

cpu_possible - indicates cpu may be available, but may not be present in the system. Hence
different from phys_cpu_present_mask

cpu_possible wont change dynamically but present_map can change depending on the arrival of 
cpu's in a system. I implemented it for only ia64, and expection is that ACPI or its equilvalent
would populate cpu_present_map dynamically.

In architectures that dont have cpu_hotplug capability, i have kept cpu_present and possible the same.


Once i take a look at the failures, i will send you an updated patch. again really sorry for the
inconvenience.

Cheers,
ashok
