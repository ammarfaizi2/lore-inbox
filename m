Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWBVMIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWBVMIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBVMIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:08:48 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:39581 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1750721AbWBVMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:08:47 -0500
Message-ID: <43FC54B8.7070706@qazi.f2s.com>
Date: Wed, 22 Feb 2006 12:10:32 +0000
From: Asfand Yar Qazi <ay0106@qazi.f2s.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua>
In-Reply-To: <200602221130.13872.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Wednesday 22 February 2006 09:43, Asfand Yar Qazi wrote:
> 
>>'Scuse my noobness, but when I supply the following parameter to the arguments 
>>  of my kernel through GRUB, I get an 'undefined mode' error:
>>
>>vga=0164
>>
>>But then, when the prompt comes up asking me which mode I want I type in:
>>
>>0164
>>
>>and I get the required mode!
> 
> 
> vga parameter is not passed to kernel itself, it is parsed by bootloader.
> Previously, booploaders had bugs versus vga=NN specified in hex and/or octal.
> Try entering decimal value.

OK, will try that.  decimal of octal(0164) = decimal(116)

> 
> 
>>What's happening?  On 2.4 kernel, I used to boot with vga=0x0a (which is the 
>>same mode as 0164) and it would boot fine.  Not anymore...
> 
> 
> 0x0a != 0164, that's for sure
> --
> vda
> 


OK, allow me to explain:

When the modes come up on screen, they are numbered (0, 1, 2, ... a, b, etc.) 
  This is what the 'a' refers to.  Hey, it worked through LILO on 2.4 kernels.

Before I type in scan, the number for the 132x60 mode is actually 030C.  After 
I've typed in 'scan', then it comes up as 0164.  If I enter 0164 BEFORE I type 
in 'scan' at the vid mode, it still works.  But not if I give it as argument 
to GRUB.  As I said, will try giving decimal equivalent (116) as argument to GRUB.

