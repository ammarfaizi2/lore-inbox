Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUBLHbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUBLHbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:31:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:45239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266248AbUBLHbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:31:04 -0500
X-Authenticated: #4512188
Message-ID: <402B2BAE.9090208@gmx.de>
Date: Thu, 12 Feb 2004 08:30:54 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de> <400EC908.4020801@gmx.de> <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu>            <402AAB2C.8050207@gmx.de> <200402120552.i1C5qAHS024041@turing-police.cc.vt.edu>
In-Reply-To: <200402120552.i1C5qAHS024041@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 11 Feb 2004 23:22:36 +0100, "Prakash K. Cheemplavam" said:
> 
> 
>>>If this is the NVidia graphics driver, it's been doing it at least since 2.
> 
> 5.6something,
> 
>>>at least that I've seen.  It's basically calling pci_find_slot in an interr
> 
> upt context,
> 
>>>which ends up calling pci_find_subsys which complains about it.  One possib
> 
> le
> 
>>>solution would be for the code to be changed to call pci_find_slot during m
> 
> odule
> 
>>>initialization and save the return value, and use that instead.  Yes, I kno
> 
> w this
> 
>>>prevents hotplugging.  Who hotplugs graphics cards? ;)
>>
>>Could you advise me how to make a dirty hack to get this going? Once 
>>again I am back to 2.6.1-rc1 kernel, which seems to be the last one 
>>stable for me. 2.6.3-rc1-mm1 locked up quite fast..
> 
> 
> 1) 'badness in pci_find_subsys' is a warning only.  If your system is
> locking up, there's something else at issue, probably.
> 
> 2) NVidia released the 5336 level of drivers, which apparently have been
> fixed to support 2.6 without the warning being triggered.

Well, I don't know whether my system actually locks up, it is like it 
seems the log gets flooded (when I wait long enough) but I cannot do 
anything with the system at that point, ie it seems like frozen. 
Furthermore I am using latest 53.36 drivers and I am not the only one 
having this problem if I look into nvnews forums. As I said this is a 
problem which came with something changed in the newer kernels. 2.6.1 
(and 2.6.2-rc1) works OK for me, 2.6.2-rc2 and later not.

Prakash
