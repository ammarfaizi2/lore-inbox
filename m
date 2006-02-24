Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWBXEuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWBXEuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWBXEuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:50:46 -0500
Received: from relay4.usu.ru ([194.226.235.39]:60084 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932589AbWBXEup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:50:45 -0500
Message-ID: <43FE90D6.1060801@ums.usu.ru>
Date: Fri, 24 Feb 2006 09:51:34 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: zcat: stdin: decompression OK
References: <20060220042615.5af1bddc.akpm@osdl.org> <43FC6B8F.4060601@ums.usu.ru> <20060222225325.10a71472.rdunlap@xenotime.net> <20060223182107.GB7803@mipter.zuzino.mipt.ru>
In-Reply-To: <20060223182107.GB7803@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.23; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Wed, Feb 22, 2006 at 10:53:25PM -0800, Randy.Dunlap wrote:
>> On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:
>>> Unfortunately, I lost my .config from the old kernel, so I attempted the
>>> following:
>>>
>>> cd scripts
>>> make binoffset
>>> cd ..
>>> scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config
>>>
>>> This results in:
>>>
>>> zcat: stdin: decompression OK, trailing garbage ignored
>> No other output?  what $ARCH?
>> What did the .config file contain?  was it correct?
>> so is the only problem the zcat warning message?
>>
>> I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).
> 
> Since I can reproduce it, Randy, what version do you use? 1.3.5-r8 here
> from Gentoo.
> 
> At least, we can trivially shut it up.

I think this would be wrong, because I am able to extract the config 
without warnings from 2.6.15-mm2 or even vanilla 2.6.16-rc4, but not 
vmlinuz-2.6.16-rc3-mm1. So something changed in -mm between 2.6.15-mm2 
and 2.6.16-rc3-mm1 in the way how bzImages are produced.

-- 
Alexander E. Patrakov
