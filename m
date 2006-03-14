Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751967AbWCNXzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbWCNXzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWCNXzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:55:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751967AbWCNXzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:55:32 -0500
Message-ID: <4417580B.2090205@ce.jp.nec.com>
Date: Tue, 14 Mar 2006 18:55:55 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Greg KH <gregkh@suse.de>, maule@sgi.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
References: <44172F0E.6070708@ce.jp.nec.com> <20060314215736.GV13973@stusta.de>
In-Reply-To: <20060314215736.GV13973@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>>include2/asm/msi.h: In function `ia64_msi_init':
>>include2/asm/msi.h:23: warning: implicit declaration of function `msi_register'
>>In file included from include2/asm/machvec.h:408,
>>                 from include2/asm/io.h:70,
>>                 from include2/asm/smp.h:20,
>>                 from /build/rc6/source/include/linux/smp.h:22,
>>...
> 
> To avoid any wrong impression:
> 
> This kind of warnings isn't harmless.
> 
> gcc tries to guess the prototype of the function, and if gcc guessed 
> wrong this can cause nasty and hard to debug runtime errors.

Sure.
But for this case, gcc emits the above warning for any files
which includes, for example, include/linux/smp.h on ia64.
So while the warning is harmless, it may cause other harmful
warnings being overlooked.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
