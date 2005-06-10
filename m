Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVFJAKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVFJAKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 20:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFJAKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 20:10:49 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:29358 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261830AbVFJAKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 20:10:41 -0400
Message-ID: <42A8DA7E.8010908@bigpond.net.au>
Date: Fri, 10 Jun 2005 10:10:38 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.1 for 2.6.12-rc6 and 2.6.12-rc6-mm1
References: <42A68159.9050808@bigpond.net.au> <200506091042.19987.kernel@kolivas.org>
In-Reply-To: <200506091042.19987.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.132.202] using ID pwil3058@bigpond.net.au at Fri, 10 Jun 2005 00:10:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 8 Jun 2005 03:25 pm, Peter Williams wrote:
> 
>>The patch of PlugSched-5.1 for 2.6.12-rc5 applies cleanly to 2.6.12-rc6
>>and is available at:
> 
> 
> Hi Peter
> 
> The recent fix that Ingo posted for the changes to pipe code affects 
> significantly the behaviour of the mainline scheduler and should be 
> incorporated as soon as possible. Staircase has undergone substantial 
> revision in response to this change, fortunately to its advantage removing 
> all that extra code I added to your last plugsched version. Anyway here is a 
> patch committing Ingo's pipe signalling changes, and the update to staircase 
> 11.3 in line with those changes. None of this changes the way the other cpu 
> schedulers behave but it may be worth investigating how the pipe changes 
> affect the behaviour of the ones you maintain.
> 

Thanks.  I've incorporated this patch plus some modifications to the 
Zaphod scheduler to take advantage of the TASK_NONINTERACTIVE flag into 
v-5.2 of PlugSched for 2.6.11, 2.6.12-rc6 and 2.6.12-rc6-mm1 kernels. 
Patches to upgrade v-5.1 to v-5.2 are available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-to-5.2-for-2.6.11.patch?download>
<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-to-5.2-for-2.6.12-rc6.patch?download>
<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-to-5.2-for-2.6.12-rc6-mm1.patch?download>

I noticed when doing this conversion that I had botched the propagation 
of your staircase 11.2 patches into the 2.6.12-rc6-mm1 kernel and anyone 
using the staircase scheduler in that kernel is advised to upgrade to 
this patch.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
