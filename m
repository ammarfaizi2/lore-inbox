Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWDLHpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWDLHpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 03:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWDLHpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 03:45:05 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:27031 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932092AbWDLHpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 03:45:04 -0400
Message-ID: <443CB181.40008@sw.ru>
Date: Wed, 12 Apr 2006 11:51:29 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>	<200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp>	<4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com>	<443B873B.9040908@sw.ru> <p73mzer4bti.fsf@bragg.suse.de>	<443CA47E.4070809@sw.ru> <p73irpf473y.fsf@bragg.suse.de>
In-Reply-To: <p73irpf473y.fsf@bragg.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>How would that work when x86-64 32bit programs have 4GB of address
>>>space and native on i386 programs only 3GB?
>>
>>we limit address space of i386 apps on x86-64 to 3GB due to
>>compatibility issues - some applications don't work with not 3:1 GB VM
>>split.
> 
> The only program I'm aware of with this problem is an very old JDK
> used in the Oracle installer - and the official documented fix
> for this is to run it with linux32 --3gb
> 
> Limiting everybody just for that single bug seems quite excessive.
Sergey Vlasov recently reported some other apps:

-------------- cut ---------------
Changing PAGE_OFFSET this way would break at least Valgrind (the latest
release 3.1.0 by default is statically linked at address 0xb0000000, and
PIE support does not seem to be present in that release).  I remember
that similar changes were also breaking Lisp implementations (cmucl,
sbcl), however, I am not really sure about this.
-------------- cut ---------------

Also, why would one expect 4GB of VM on x86-64 if normally have 3GB on 
i686? Anyway, as it is tunable, people can select which one they prefer.

Thanks,
Kirill

