Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVIFUXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVIFUXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVIFUXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:23:48 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:11526 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750865AbVIFUXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:23:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ggsJr7pavdXEhGo8Mwy3uIDprAyU/j5Dxn9NExP/MoXisbKdqjR8laIqw2B8c6KOhhtc3+V/YjRtIVvOyo/vtxwmvY+Zzj6Uo2SXUFDrKkzoX8iyOsgNfrEKo3578rHblqYsKOLGLImQQp9JhFk5aRu8Bp2L4/BHGTBJgdeDto4=
Message-ID: <431DF9E9.5050102@gmail.com>
Date: Tue, 06 Sep 2005 23:19:53 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com>
In-Reply-To: <431628D5.1040709@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Chris Wedgwood wrote:
> 
>> On Wed, Aug 31, 2005 at 02:29:44PM -0700, H. Peter Anvin wrote:
>>
>>> I think someone on the SYSLINUX mailing list already sent a patch to
>>> akpm to make 512 the default; making it configurable would be a
>>> better idea.  Feel free to send your patch through me.
>>
>>
>> So we really need this to be a configuration option?  We have too many
>> of those already.
> 
> 
> Maybe not.  Another option would simply be to bump it up significantly 
> (2x isn't really that much.)   4096, maybe.
> 
>     -hpa
> 

Hello Peter, I've written a reply before but got no response...

The idea of putting arguments in initramfs is not practical, 
since the whole idea is to have the same image of system and 
affecting its behavior using the boot loader...

I would like to push forward the idea to extend the 
command-line size...

All we need for start is an updated version of the "THE 
LINUX/I386 BOOT PROTOCOL" document that states that in the 
2.02+  protocol the boot loader should set cmd_line_ptr to a 
pointer to a null terminated string without any size 
restriction, specifying that the kernel will read as much as 
it can.

After I get this update, I will try to work with GRUB and LILO 
so that they will fix their implementation. Currently they 
claim that they understand that they should truncate the 
string to 256.

After that I will provide my simple  patch for setting the 
maximum size the kernel allocates in the configuration.

BTW: Do you know why the COMMAND_LINE_SIZE constant is located 
in two separate include files?

Best Regards,
Alon Bar-Lev.
