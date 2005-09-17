Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVIQPDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVIQPDb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIQPDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:03:31 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:44394 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751039AbVIQPDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:03:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Vn7eT2bJXU3aGokD2YrBk8kI6jXeyz9eQDs7bRkeoJjKdD0CCcsAcp7ehslMPlPXqHUaabjVpDR8MFsWpwSnTElyzhNihYzYHNSjkdhWooM6RfSjrVgcz2IWs54yaZjsyeoldUicUVifbR3LoccFw3SbXPRxzakTw9VKtklaHsk=
Message-ID: <432C303B.7040804@gmail.com>
Date: Sat, 17 Sep 2005 17:03:23 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1 Critical bug: machine complete freeze
References: <432BE118.5090008@gmail.com> <20050917024116.6e16529b.akpm@osdl.org>
In-Reply-To: <20050917024116.6e16529b.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton ha scritto:

>Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>  
>
>>Hi.
>>
>>i'm using 2.6.14-rc1.
>>
>>1 second after starting samba (3.0.20) machine freezes completly.
>>no way to resume it, just hardware reset.
>>
>>I can't provide backtraces or logs, there isn't a logged kernel panic, 
>>nor other log.
>>Immedially freezed.
>>
>>2.6.13 works.
>>
>>Of course same smb.conf and same .config.
>>
>>    
>>
>
>Please enable CONFIG_DEBUG_SLAB, CONFIG_DEBUG_PAGE_ALLOC,
>CONFIG_X86_LOCAL_APIC and add `nmi_watchdog=1' to the kernel boot command
>line.
>
>
>  
>
ok... done..

here the backtrace:
http://blight.altervista.org/1.jpg
http://blight.altervista.org/2.jpg

however i found the problem:

the new ipfilter netbios module.
not compiling it fixed the panic.
net team please fix that :)


