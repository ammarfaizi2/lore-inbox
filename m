Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWJRHBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJRHBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWJRHBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:01:20 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:36777 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750743AbWJRHBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:01:20 -0400
Date: Wed, 18 Oct 2006 08:01:17 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Ryan Richter <ryan@tau.solarneutrino.net>
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
In-Reply-To: <4535CFB1.2010403@tungstengraphics.com>
Message-ID: <Pine.LNX.4.64.0610180800150.16077@skynet.skynet.ie>
References: <20061013194516.GB19283@tau.solarneutrino.net>
 <1160849723.3943.41.camel@neko.keithp.com> <20061017174020.GA24789@tau.solarneutrino.net>
 <1161124062.25439.8.camel@neko.keithp.com> <4535CFB1.2010403@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does the DRM git tree work would also be interesting,...

I haven't merged up Michel's drawable/blank changes for 2.6.19 as they 
were much too new for it, but do we have a backwards compat issue perhaps 
or something similiar?

Dave.

On Wed, 18 Oct 2006, Keith Whitwell wrote:

> This is all a little confusing as the driver doesn't really use that
> path in normal operation except for a single command - MI_FLUSH, which
> is shared between the architectures.  In normal operation the hardware
> does the validation for us for the bulk of the command stream.  If there
>  were missing functionality in that ioctl, it would be failing
> everywhere, not just in this one case.
>
> I guess the questions I'd have are
> 	- did the driver work before the kernel upgrade?
> 	- what path in userspace is seeing you end up in this ioctl?
> 	- and like Keith, what commands are you seeing?
>
> The final question is interesting not because we want to extend the
> ioctl to cover those, but because it will give a clue how you ended up
> there in the first place.
>
> Keith
>
> Keith Packard wrote:
>> On Tue, 2006-10-17 at 13:40 -0400, Ryan Richter wrote:
>>
>>> So do I want something like
>>>
>>>
>>> static int do_validate_cmd(int cmd)
>>> {
>>> 	return 1;
>>> }
>>>
>>> in i915_dma.c?
>>
>> that will certainly avoid any checks. Another alternative is to printk
>> the cmd which fails validation so we can see what needs adding here.
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job easier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>>
>>
>> ------------------------------------------------------------------------
>>
>> --
>> _______________________________________________
>> Dri-devel mailing list
>> Dri-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/dri-devel
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

