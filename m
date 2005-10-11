Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVJKUev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVJKUev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVJKUev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:34:51 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:35144 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751277AbVJKUeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:34:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E0N4iYSz8F/wVdasKcHAn7JHd9mX3YGf4Fg9XAN1IRvRO3k7H56kioTh7lFun8dkevoFcAbnAYOU63V9g6Cos7rRmJgg9i5+W7+ytNaY3+Hg1aixXNrH40ny1XQtMwCjItVwkylHmfqBGe4bHAz3oGZ8TFcSbhwgzLfI6Cs6Iy0=
Message-ID: <434C1AB6.5000104@gmail.com>
Date: Tue, 11 Oct 2005 22:04:06 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Georg Lippold <georg.lippold@gmx.de>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <p73br1vsvup.fsf@verdi.suse.de> <434C1189.4090207@gmail.com> <200510112221.05789.ak@suse.de>
In-Reply-To: <200510112221.05789.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> It's a bad idea to have a CONFIG for every buffer. If we go down this way
> this way we end up with a unconfigurable kernel at some point with
> hundreds of obscure parameters. Just increase it if there is a need for it.
> If you're really worried about memory consumption you can
> make the big buffer __initdata and copy it to a newly allocated buffer of the 
> right size.

OK... So I think 1024 bytes should be used... Does it sound OK?

But I still think that the documentation should not specify 
a fixed size, so that boot loaders will pass the full 
command line to the kernel.

Best Regards,
Alon Bar-Lev.
