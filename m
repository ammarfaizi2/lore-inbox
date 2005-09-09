Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVIIU4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVIIU4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbVIIUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:55:59 -0400
Received: from fmr23.intel.com ([143.183.121.15]:22727 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030305AbVIIUz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:55:59 -0400
Date: Fri, 9 Sep 2005 13:55:56 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Christopher Beppler <psiml@funzi.de>
Cc: linux-kernel@vger.kernel.org, li.shaohua@intel.com
Subject: Re: [OOPS] hotplugging cpus via /sys/devices/system/cpu/
Message-ID: <20050909135556.A29542@unix-os.sc.intel.com>
References: <4321F396.3010707@funzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4321F396.3010707@funzi.de>; from psiml@funzi.de on Fri, Sep 09, 2005 at 01:41:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 01:41:58PM -0700, Christopher Beppler wrote:
> 
>    [1.] One line summary of the problem:
>    If I deactivate a CPU with /sys/devices/system/cpux and try to
>    reactivate it, then the CPU doesn't start and the kernel prints out an
>    oops.
> 

Could you try this on 2.6.13-mm2? If this is due to a sending broadcast
IPI related issue that should fix the problem.

I should say i didnt try i386 in a while
but i suspect some of the recent suspend/resume code required some
modifications to the i386 hotplug code which might be getting in the way
if you just try logical cpu hotplug alone without using it for suspend/resume.

Shaohua might know more about the status.

Cheers,
ashok
