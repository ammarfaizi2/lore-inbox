Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUIPSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUIPSKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUIPSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:10:05 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:6667 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268535AbUIPSI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:08:58 -0400
Message-ID: <4149D8C6.1060407@hp.com>
Date: Thu, 16 Sep 2004 14:17:42 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
References: <200409161003.39258.bjorn.helgaas@hp.com> <200409160909.12840.jbarnes@engr.sgi.com> <1095349940.22739.34.camel@localhost.localdomain> <200409161007.37015.jbarnes@engr.sgi.com>
In-Reply-To: <200409161007.37015.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:

>On Thursday, September 16, 2004 8:52 am, Alan Cox wrote:
>  
>
>>On Iau, 2004-09-16 at 17:09, Jesse Barnes wrote:
>>    
>>
>>>I think Christoph already looked at that.  And HPET doesn't provide mmap
>>>functionality, does it?  I.e. allow a userspace program to dereference
>>>the counter register directly?
>>>      
>>>
>>It can do but that assumes nothing else is mapped into the same page
>>that would be harmful or reveal information that should not be revealed
>>etc..
>>    
>>
>
>And what about the register layout?  mmtimer makes sure that the register is 
>on a page by itself before it allows the mmap, and only exports the counter 
>register itself.  Can hpet do that?
>
>Jesse
>
>  
>
The hpet driver checks that the mapping is page aligned.  It's up to the 
platform to provide this alignment.  It's also dependent on the platform 
for what resides in the page.  Also the configured page size could 
impact what is within the page.
