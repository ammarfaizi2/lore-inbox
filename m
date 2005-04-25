Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVDYXNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDYXNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVDYXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:13:21 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:22733 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261163AbVDYXNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:13:18 -0400
Message-ID: <426D797D.3000108@ammasso.com>
Date: Mon, 25 Apr 2005 18:13:01 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Bob Woodruff <robert.j.woodruff@intel.com>
CC: "'Andrew Morton'" <akpm@osdl.org>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbsimplementation
References: <ORSMSX408FRaqbC8wSA00000014@orsmsx408.amr.corp.intel.com>
In-Reply-To: <ORSMSX408FRaqbC8wSA00000014@orsmsx408.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Woodruff wrote:

> There definitely needs to be a mechanism to prevent people from pinning
> too much memory. 

Any limit would have to be very high - definitely more than just half.  What if the 
application needs to pin 2GB?  The customer is not going to buy 4+ GB of RAM just because 
Linux doesn't like pinning more than half.  In an x86-32 system, that would required PAE 
support and slow everything down.

Off the top of my head, I'd say Linux would need to allow all but 512MB to be pinned.  So 
you have 3GB of RAM, Linux should allow you to pin 2.5GB.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
