Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUDHRwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDHRwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:52:02 -0400
Received: from colin2.muc.de ([193.149.48.15]:54022 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262109AbUDHRv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:51:27 -0400
Date: 8 Apr 2004 19:51:26 +0200
Date: Thu, 8 Apr 2004 19:51:26 +0200
From: Andi Kleen <ak@muc.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Andy Whitcroft <apw@shadowen.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: HUGETLB commit handling.
Message-ID: <20040408175126.GA72736@colin2.muc.de>
References: <1IKJu-Zn-29@gated-at.bofh.it> <m3u0zuwgbf.fsf@averell.firstfloor.org> <40758A74.3040107@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40758A74.3040107@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The other problem we are wrestling with is how to do the ia386 and ia64 
> lazy allocation code without breaking the architectures that haven't yet 
> switched to lazy allocation.  There will probbaly be some
> 
> #define ARCH_USES_HUGETLB_PREFAULT
> 
> nonsense added to deal with the latter, if needed.

In my patch I just used weak functions: use a dummy weak function
in the high level code and overwrite from the architecture specific 
code as needed. This avoids all the ifdefs.

-Andi
