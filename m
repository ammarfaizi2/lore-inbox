Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263857AbVBEIbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbVBEIbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 03:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbVBEIbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 03:31:37 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:45001 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263857AbVBEIb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 03:31:27 -0500
Message-ID: <4204845E.10606@free.fr>
Date: Sat, 05 Feb 2005 09:31:26 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [patch] ns558 bug
References: <4203D476.4040706@free.fr>	<20050205004311.GA7998@neo.rr.com> <20050204190614.6cfd68ce.akpm@osdl.org>
In-Reply-To: <20050204190614.6cfd68ce.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ambx1@neo.rr.com (Adam Belay) wrote:
> 
>>On Fri, Feb 04, 2005 at 09:00:54PM +0100, matthieu castet wrote:
>> > Hi,
>> > 
>> > this patch is based on http://bugzilla.kernel.org/show_bug.cgi?id=2962 
>> > patch from adam belay.
>> > 
>> > It solve a oops when pnp_register_driver(&ns558_pnp_driver) failed.
>> > 
>> > Please apply this patch.
>> > 
>> > Matthieu
>>
>> I remember writing a version of this patch a while ago.  The current behavior
>> is broken because it shouldn't be considered a failure if the driver doesn't
>> find any devices.
Why ?
If isa detection failed, the modules could not find any new isa devices.
If the pnp detection find no device, the module is load.
If it is the kernel modules behaviour, lot's of modules are broken...

If you want that, why not simply alway "return 0" in the __init like it 
is done in the bugzilla patch ?


Matthieu
