Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVLOBxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVLOBxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVLOBxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:53:24 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47038 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751094AbVLOBxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:53:23 -0500
Message-ID: <43A0CCAD.2030903@jp.fujitsu.com>
Date: Thu, 15 Dec 2005 10:53:49 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Jones <davej@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add mem_nmi_panic enable system to panic on hard error
References: <439E6C58.6050301@jp.fujitsu.com>	 <20051213064800.GB7401@redhat.com>	 <1134476618.11732.7.camel@localhost.localdomain>	 <439FDCB0.7030705@jp.fujitsu.com> <1134558344.25663.8.camel@localhost.localdomain>
In-Reply-To: <1134558344.25663.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I could find your code in the -mm tree. It looks good :-)
>>But just one point, isn't it better to use die_nmi() instead of panic()?
>>
>> >>        if (panic_on_unrecovered_nmi)
>> >>                panic("NMI: Not continuing");
> 
> 
> At the point we halt for an unrecovered NMI the call trace isnt likely
> to be interesting and the message being visible is most important. I'm
> not sure if die_nmi would be better therefore - dunno what other folks
> think ?

Indeed, that's true.
In this case of an unrecovered NMI, the call trace is useless.
Thank you for pointing it out.

H.Seto

