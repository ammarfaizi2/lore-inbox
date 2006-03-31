Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWCaXPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWCaXPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWCaXPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:15:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:7881 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932122AbWCaXPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:15:04 -0500
Message-ID: <442DB7F0.8090000@garzik.org>
Date: Fri, 31 Mar 2006 18:14:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
References: <20060331040613.GA23511@havoc.gtf.org> <1143802879.3053.3.camel@laptopd505.fenrus.org> <20060331110233.GM14022@suse.de> <442D3608.8090906@garzik.org> <20060331183617.GD14022@suse.de>
In-Reply-To: <20060331183617.GD14022@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Mar 31 2006, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> On Fri, Mar 31 2006, Arjan van de Ven wrote:
>>>> On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
>>>>> Woe be unto he who builds their filesystems as modules.
>>>> since splice support is highly linux specific and new.. shouldn't these
>>>> be _GPL exports?
>>> Yes they should, I'll add that to the current splice tree.
>> Why?  We don't usually restrict filesystems in such ways...  I would 
>> rather a binary-only module reference generic_file_splice_read() than 
>> create its own.
> 
> You could use that very same argument for any piece of the kernel, then,
> so I don't think that adds much value to _not_ exporting it GPL.

Not really, because I'm considering the Real World(tm) users, not 
abstract theory :)  The other filesystem junk is exported non-GPL, and 
existing binary-only filesystems use that stuff.

IOW its a bit rude to say "oh you can have your BO filesystem, just not 
splice support."

	Jeff



