Return-Path: <linux-kernel-owner+w=401wt.eu-S1030205AbXAKICL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbXAKICL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXAKICL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:02:11 -0500
Received: from il.qumranet.com ([62.219.232.206]:52580 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030205AbXAKICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:02:10 -0500
Message-ID: <45A5EF00.4070802@qumranet.com>
Date: Thu, 11 Jan 2007 10:02:08 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
References: <45A39A97.5060807@qumranet.com> <200701110826.28535.arnd@arndb.de>
In-Reply-To: <200701110826.28535.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Tuesday 09 January 2007 14:37, Avi Kivity wrote:
>   
>> struct kvm_vcpu_area {
>>     u32 vcpu_area_size;
>>     u32 exit_reason;
>>
>>     sigset_t sigmask;  // for use during vcpu execution
>>     
>
> Since Jeff brought up the point of 32 bit compatibility:
> When this structure is shared between 64 bit kernel and
> 32 bit user space, you sigmask should be a __u64 in order
> to guarantee compatibility.
>   

Right.  Thanks.

-- 
error compiling committee.c: too many arguments to function

