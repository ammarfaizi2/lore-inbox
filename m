Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVEXFqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEXFqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 01:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXFqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 01:46:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:6116 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261257AbVEXFqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 01:46:15 -0400
Date: Tue, 24 May 2005 11:16:17 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@muc.de>, zwane@arm.linux.org.uk, discuss@x86-64.org,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050524054617.GA5510@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523104046.B8692@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 10:40:46AM -0700, Ashok Raj wrote:
> Iam not a 100% sure about above either, if the smp_call_function 
> is started with 3 cpus initially, and 1 just came up, the counts in 
> the smp_call data struct could be set to 3 as a result of the new cpu 
> received this broadcast as well, and we might quit earlier in the wait.

True.

> sending to only relevant cpus removes that ambiquity. 

Or grab the 'call_lock' before setting the upcoming cpu in the online_map.
This should also avoid the race when a CPU is coming online.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
