Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTLJDD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTLJDD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:03:58 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:6853 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263462AbTLJDD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:03:57 -0500
Message-ID: <3FD68F08.7010905@pacbell.net>
Date: Tue, 09 Dec 2003 19:12:08 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Alan Stern <stern@rowland.harvard.edu>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org> <200312092307.04924.baldrick@free.fr> <3FD64BD9.1010803@pacbell.net> <200312092333.33562.baldrick@free.fr>
In-Reply-To: <200312092333.33562.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
>>>It occurred on system shutdown - so I guess the module was unloaded.
>>>Maybe the bus reference counting is borked.
>>
>>Various folk have reported similar problems on system shutdown
>>before, and the simple fix has been not to clean up so aggressively.
> 
> 
> ?

Like:  don't rmmod during system shutdown.  Some distros do that,
others don't.  Or maybe it was individual customization, I don't
recall (never having had the issue myself).


>>What puzzled me was that a normal "rmmod" wouldn't give the
>>same symptoms -- but the same codepaths could oops in certain
>>system shutdown scenarios.
> 
> 
> Duncan.
> 


