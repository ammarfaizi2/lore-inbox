Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWCVRJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCVRJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWCVRJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:09:41 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61165 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750714AbWCVRJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:09:40 -0500
Message-ID: <442184B9.2020507@us.ibm.com>
Date: Wed, 22 Mar 2006 11:09:13 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
CC: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt wrote:
>> This seems to be pretty evil and creating interesting failure 
>> conditions for users who load IDE or SCSI modules.  I've seen 
>> it trip up a number of people in the past.  I think we should 
>> only ever use the major number that was actually allocated to us.
>>     
>
> We certainly should be pushing everyone toward using the 'xdX' etc
> devices that are allocated to us. However, the installers of certain
> older distros and other user space tools won't except anything other
> than hdX/sdX, so its useful from a compatibility POV even if it never
> goes into mainline, which I agree it probably shouldn't. 
>   

Then perhaps we should deprecate non xd block devices starting in the 
near future (3.0.3?).  We probably need to have it deprecated for a few 
releases since I think most people are not using xd at this point...

Regards,

Anthony Liguori

> Ian
>   

