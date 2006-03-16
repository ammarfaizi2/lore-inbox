Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWCPMEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWCPMEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 07:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWCPMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 07:04:05 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:2258 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750790AbWCPMED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 07:04:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=cO7oUwJAtT+FqUyypTTRJOLAJfSidbCKYrnxupmBjY+uW/AMM9lSpUIhGWl9dsuJhmnVsLs4Dds/DHaetfb+Jmb8LQ1k75kKbQ1YvidHLm3HGyt3XzdKfgePg9m8IUwAnXjv0ScjvJjGF7Y0E4dkE11tEY8q6m8N+ZBOFLREKoA=
Message-ID: <44195429.8070809@gmail.com>
Date: Thu, 16 Mar 2006 13:03:53 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060224)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-git6 compilation fails (input system)
References: <441946AA.2070006@gmail.com> <20060316113206.GB3914@stusta.de>
In-Reply-To: <20060316113206.GB3914@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk ha scritto:
> On Thu, Mar 16, 2006 at 12:06:18PM +0100, Patrizio Bassi wrote:
>   
>> i've a problem with gcc 4.1.0
>>
>>
>> LD drivers/ide/built-in.o
>> CC drivers/input/input.o
>> In file included from drivers/input/input.c:16:
>> include/linux/input.h:957: warning: ‘struct input_device_id’ declared
>> inside parameter list
>> include/linux/input.h:957: warning: its scope is only this definition or
>> declaration, which is probably not what you want
>> drivers/input/input.c: In function ‘input_register_device’:
>> drivers/input/input.c:842: warning: passing argument 3 of
>> ‘handler->connect’ from incompatible pointer type
>> drivers/input/input.c: In function ‘input_register_handler’:
>> drivers/input/input.c:898: warning: passing argument 3 of
>> ‘handler->connect’ from incompatible pointer type
>> ...
>>     
>
> Please send your .config .
>
> cu
> Adrian
>
>   
remving joystick interface fixed it, but a nice warning still remains:

In file included from drivers/input/serio/libps2.c:19:
include/linux/input.h:957: warning: ‘struct input_device_id’ declared
inside parameter list
include/linux/input.h:957: warning: its scope is only this definition or
declaration, which is probably not what you want


this should be the cause of the problem.

Patrizio
