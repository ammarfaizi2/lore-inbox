Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWCVRvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWCVRvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWCVRvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:51:01 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53225 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932246AbWCVRvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:51:00 -0500
Message-ID: <44218E6A.1020304@us.ibm.com>
Date: Wed, 22 Mar 2006 11:50:34 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
References: <20060322063040.960068000@sorel.sous-sol.org> <4421863C.4070403@us.ibm.com> <20060322172711.GW15997@sorel.sous-sol.org>
In-Reply-To: <20060322172711.GW15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Anthony Liguori (aliguori@us.ibm.com) wrote:
>   
>> Chris Wright wrote:
>>     
>>> Xen also provides support for running directly on native hardware.
>>>       
>> Can someone elaborate on this?  Does this mean a Xen guest can run on 
>> bare metal?
>>     
>
> Yes.  See the Xen code for running the kernel in ring0 with Xen
> (supervisor_mode_kenel).  The hypercall_page is conditionally filled
> with hypercall traps or direct calls basically.
>   

Cool!  I didn't realize the supervisor_mode_kernel code was in the Xen 
tree code already.

Regards,

Anthony Liguori

>> Is there code available to make this work (it doesn't seem contained in 
>> this patchset)?  Has any performance analysis been done?
>>     
>
> I don't have any numbers.
>
>   
>> The numbers that have been posted with the VMI patches suggest that some 
>> rather tricky stuff is required to achieve native performance when 
>> running a guest on bare metal.  If this is not the case, it would be 
>> very interesting to know because it seems to be the hairiest part of the 
>> VMI patches.
>>     
>
> It is a hairy part of VMI.  They've done a nice job of handling the
> native case, and have interseting plans for improving the non-native
> case (inline where possible).  One of the differences is things that
> don't actually require hypercalls are already inline w/ Xen.  So it's
> conceivable that the performance hit is smaller than what VMI found
> without carefully inlining native code.
>
>   
>> Otherwise, if we want to support Xen guests on bare metal, it seems we 
>> would have to change things in the subarch code a bit to do something 
>> similar to VMI.
>>     
>
> It's a different approach.
>
> thanks,
> -chris
>   

