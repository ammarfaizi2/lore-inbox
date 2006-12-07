Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163210AbWLGTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163210AbWLGTIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163213AbWLGTIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:08:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:51622 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163210AbWLGTIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:08:12 -0500
Message-ID: <457866BF.6070503@us.ibm.com>
Date: Thu, 07 Dec 2006 13:08:47 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: upcall sample patch]
References: <457865F6.7050204@us.ibm.com>
In-Reply-To: <457865F6.7050204@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> For the CIFS Kerberos/SPNEGO case the Kerberos ticket can end up 
> almost 64K in size and need to be passed down by Samba userspace 
> helpers to kernel (for sending over the kernel socket to the server in 
> the data area of the smb that the kernel cifs code formats).
>
> Is the limit on the Linux kernel connector really 1K for passing down 
> to kernel?
>
> On Wed, 2006-12-06 at 17:55 -0600, Steve French wrote:
>   
>> simo wrote:
>>     
>>> Steve,
>>> I am experimenting using netlink.
>>>
>>> I could v. easily send messages from user space to the kernel module,
>>> adapting the provided examples. I am finding some difficulty in
>>> understanding how the other way around is supposed to work though.
>>>
>>> However while digging into headers, I found that currently the maximum
>>> message size is set to 1024 bytes. That's a bit annoying.
>>>
>>>
>>>       
>> Linux kernel connector is the preferred netlink wrapper and it has
>> sample programs that I found.
>> Not sure the maximum size
>>     
>
> Steve I looked into the sample programs in 2.6.19, cn_test.c and ucon.c
> are provided. Unfortunately it is not clear from them how to make
> upcalls. It is very easy to make downcalls, but I found it hard to find
> out what's the right way to catch messages sent from the kernel in the
> user space. Do you have nay other examples?
>
> For the limit, just look in linux/connector.h there you can find a
> define that sets the MAX LEN of the message to 1024.
>
> Simo.
>   
