Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVIALfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVIALfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIALfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:35:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18882 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932431AbVIALfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:35:11 -0400
Date: Thu, 1 Sep 2005 17:03:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
Message-ID: <20050901113330.GB11145@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200509010829.35958.thomas.schlichter@web.de> <200509010942.24026.thomas.schlichter@web.de> <20050901102839.GB9936@in.ibm.com> <200509011305.24038.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509011305.24038.thomas.schlichter@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:05:23PM +0200, Thomas Schlichter wrote:
> Yes, the only real differences are the two points mentioned in my first 
> mail... I only wanted to help you fixing these.

Thanks for pointing them out. I have fixed it in the experimental version
that I have now.

> Well, that seems to be fine. If you want somebody to have a look over your 
> final patch, feel free to mail me...

sure!

> I should have defined PMTMR_TICKS_PER_JIFFY like you assigned 
> pm_ticks_per_jiffy (why did you use a static and constant variable and not a 
> macro?):

I actually started with using the calibrated value of PMTMR_TICKS_PER_JIFFY 
rather than compile time constant (as found in verify_pmtmr), but later dropped
the idea since I didnt get good results with it. After that didnt revert
back pm_ticks_per_jiffy to be a macro. But good point, will include
this in the next patch that I am trying out. Will post it if I happen
to have success :)



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
