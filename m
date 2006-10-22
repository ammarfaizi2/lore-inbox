Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWJVIRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWJVIRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWJVIRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:17:25 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:43409 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S932220AbWJVIRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:17:25 -0400
Message-ID: <453B2910.7040708@qumranet.com>
Date: Sun, 22 Oct 2006 10:17:20 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] KVM: Intel virtual mode extensions definitions
References: <4537818D.4060204@qumranet.com>  <4537823C.6030700@qumranet.com> <1161438521.16868.18.camel@localhost.localdomain>
In-Reply-To: <1161438521.16868.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 08:17:24.0652 (UTC) FILETIME=[81283EC0:01C6F5B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 2006-10-19 at 15:48 +0200, Avi Kivity wrote:
>   
>> Add some constants for the various bits defined by Intel's VT extensions.
>>
>> Most of this file was lifted from the Xen hypervisor.
>>
>> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
>> Signed-off-by: Avi Kivity <avi@qumranet.com>
>>
>> Index: linux-2.6/drivers/kvm/vmx.h
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6/drivers/kvm/vmx.h
>> @@ -0,0 +1,287 @@
>>     
>
> This entire file is also very specific to an architecture. Couldn't it
> be put somewhere in arch/x86_64 and not in drivers?
>
> I know that this is all currently focused on Intel and AMD
> virtualization platforms, but could you split out the x86_64 specific
> stuff and make the rest more generic. Perhaps in the future this will
> make it easier for other platforms to use this code as well.
>   

We're already doing some splitting since Intel and AMD have incompatible 
extensions for doing this.  The result however will still be x86 (-64 
and i386) specific.

> It's hard to do a generic approach when developing it new, but if you
> don't think about that now, it will be magnitudes larger in difficulty
> to make generic when this is all done.
>   

I don't know enough about ppc and ia64 virtualization for that.  Perhaps 
someone would like to comment.

-- 
error compiling committee.c: too many arguments to function

