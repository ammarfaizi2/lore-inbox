Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUDSUlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDSUlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:41:21 -0400
Received: from terminus.zytor.com ([63.209.29.3]:11472 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262044AbUDSUkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:40:32 -0400
Message-ID: <4084392C.7020408@zytor.com>
Date: Mon, 19 Apr 2004 13:40:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] in 2.6.5 at msr.c and cpuid.c
References: <40842288.3090501@uni-paderborn.de>
In-Reply-To: <40842288.3090501@uni-paderborn.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjoern Schmidt wrote:
> Hello H. Peter,
> 
> sorry for mailing to you directly, but sending this bugreport
> to linux-kernel@vger.kernel.org failed and i don't know why...
>
> The server was at an uptime of ~8 days until this bug appeared.
> At 15:33 the smbd was killed by Signal 7.
> 

Why is your smbd touching /dev/cpu/*/msr?  Something is very odd about
that... assuming you're not exporting /dev through Samba I would guess
this is a preemption bug.

Could you please send me a) your System.map and b) your kernel
configuration?

Could you also try disabling preemption and see if that helps?

	-hpa



