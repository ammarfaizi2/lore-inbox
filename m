Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269241AbUISO0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269241AbUISO0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUISO0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 10:26:00 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:32661 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269241AbUISOZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 10:25:58 -0400
Message-ID: <414D96EF.6030302@softhome.net>
Date: Sun, 19 Sep 2004 16:25:51 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>
CC: benh@kernel.crashing.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
References: <414C9003.9070707@softhome.net>	<1095568704.6545.17.camel@gaston>	<414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de>
In-Reply-To: <20040919140034.2257b342.Ballarin.Marc@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin wrote:
> 
>>   If there is problem, it doesn't mean we just pass it over. Probably 
>>we need to solve it?
> 
> How do you want to solve it? We cannot look into the future, so how should
> we know which device nodes "modprobe xyz" will or should create?
> dev.d is a nice solution. If any device node is created, your script is
> called. If it is the node you want, you perform your actions.
> 

   Well, can then anyone explain by which mean (black magic?) kernel 
mounts root file system? block device might appear any time, file system 
might take ages to load.

   Hu? How is init/do_mounts.c still works then? Or it is needs to be 
fixed with messages a-la "root file system will be available shortly, we 
do hope" and "please plug in again your hard-wired IDE drive"?

   People, you must learn doing abstractions carefully. If device is 
hard-wired - user *will* expect (as kernel itself does) that it is 
available all the time after modprobe'ing driver.
