Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTJHMHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 08:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTJHMHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 08:07:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60801 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261397AbTJHMHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 08:07:11 -0400
Date: Wed, 8 Oct 2003 17:44:58 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Poll-based IDE driver
Message-ID: <20031008174458.A32517@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk> <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031008115051.GD705@redhat.com>; from davej@redhat.com on Wed, Oct 08, 2003 at 12:50:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 12:50:51PM +0100, Dave Jones wrote:
> 
> Why not just use udelay() ?  The above code cannot possibly do
> the right thing on all processors.

Since my code is supposed to run when system is crashing, I would like 
to avoid calling any function in the kernel as far as possible, since 
the kernel and its data structures may be in a inconsistent state 
and/or corrupted.

I do realize that the above code does not provide accurate 
delay and may not work on all platforms. In that direction
I was considering using the loops_per_jiffy variable 
which may provide more accurate/platform-independent delay (?) ..


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
