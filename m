Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUCPUuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbUCPUuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:50:05 -0500
Received: from mail5.iserv.net ([204.177.184.155]:42444 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S261654AbUCPUt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:49:59 -0500
Message-ID: <4057687D.5050902@didntduck.org>
Date: Tue, 16 Mar 2004 15:50:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>
CC: Steve Youngs <sryoungs@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
References: <405082A2.5040304@blueyonder.co.uk> <200403130515.i2D5F7DG009253@turing-police.cc.vt.edu> <microsoft-free.87ad2ipyr2.fsf@eicq.dnsalias.org> <200403162149.41018.dominik.karall@gmx.net>
In-Reply-To: <200403162149.41018.dominik.karall@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
> On Monday 15 March 2004 04:36, Steve Youngs wrote:
> 
>>* Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
>>  > On Fri, 12 Mar 2004 18:24:01 GMT, Adam Jones <adam@yggdrasl.demon.co.uk>  
> 
> said:
> 
>>  >> A quick thought - have you got CONFIG_REGPARM enabled in the kernel
>>  >> config?  If so, disable it and try again.  (It's almost certain to
>>  >> cause crashes with binary modules.)
>>
>>  $ zgrep REGPARM /proc/config.gz
>>CONFIG_REGPARM=y
>>
>>  $ grep nvidia /proc/modules
>>nvidia 2066568 22 - Live 0xe0b2d000
>>
>>  $ uname -r
>>2.6.4-sy1
>>
>>No problems here. :-)
>>
>>  > Also, the NVidia driver uses a bit of kernel stack, so it's
>>  > incompatible with the CONFIG_4KSTACKS option in recent -mm
>>  > kernels...
>>
>>Will have to remember that for 2.6.5, I'll let you know how it goes.
>>Thanks, Valdis.
> 
> 
> can you let me know how to compile the nvidia drivers for 4KSTACK? cause in 
> the 2.6.5-rc1-mm1 is no more option to deactivate 4KSTACK.
> thx!

Complain to NVidia.  It's the binary-only part of the driver that's the 
real stack hog.

--
				Brian Gerst
