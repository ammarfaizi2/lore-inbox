Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVIFUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVIFUxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVIFUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:53:10 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:38585 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750905AbVIFUxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Nv+7icuBTJswdrfUK/xa6S2KpK94wPQb7w4cZmxgkYns/rxgZS1VrgOxbL2pScs0mnnyqUIj0462hJqz3+OXn4hCxnnhwsIFTkayGwWvg+/B231/nCl7BohyX4BcVbh4a5zNrAHCQMnTCYK9Ba9lD3NiiCyuorlVCGlRJQd7j4E=
Message-ID: <431E00C8.3060606@gmail.com>
Date: Tue, 06 Sep 2005 23:49:12 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com>
In-Reply-To: <431DFEC3.1070309@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for the reply,

H. Peter Anvin wrote:
> Alon Bar-Lev wrote:
> 
>>
>> Hello Peter, I've written a reply before but got no response...
>>
>> The idea of putting arguments in initramfs is not practical, since the 
>> whole idea is to have the same image of system and affecting its 
>> behavior using the boot loader...
>>
> 
> No, you're wrong.  The boot loader can synthesize an initramfs.

Hmm... Isn't it somewhat big change for them?
Do you mean that they can add a text file at root containing 
the command-line?
It is not so good... Since currently many scripts looks at 
/proc/cmdline and get the arguments they are interested in... 
The initramfs will not allow this... And there is no access to 
initramfs files after control is passed to root, since most 
distributions erase its contents in order to free memory...

> 
> Already pushed to Andrew.  I will follow it up with a patch to extend 
> the command line, at least to 512.

Thanks!!!
But why not making it a configuration option?
For example, I think it should be at least 1024...

Will this patch update the document?
If it does please don't specify maximum size,
The boot loader should be instructed to put unlimited 
string... OK... there is no thing like unlimited, so max 16K :)

Only the kernel should truncate it to the right size.

Best Regards,
Alon Bar-Lev.
