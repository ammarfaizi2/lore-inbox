Return-Path: <linux-kernel-owner+w=401wt.eu-S1752028AbWLXOtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbWLXOtf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 09:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbWLXOtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 09:49:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:60129 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbWLXOte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 09:49:34 -0500
Message-ID: <458E937B.9050603@garzik.org>
Date: Sun, 24 Dec 2006 09:49:31 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> <5a4c581d0612240558t1a693049l2c2f311d63681b40@mail.gmail.com>
In-Reply-To: <5a4c581d0612240558t1a693049l2c2f311d63681b40@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> On 12/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>
>> Ok,
>>  it's a couple of days delayed, because we've been trying to figure out
>> what is up with the rtorrent hash failures since 2.6.18.3. I don't think
>> we've made any progress, but we've cleaned up a number of suspects in the
>> meantime.
>>
>> It's a bit sad, if only because I was really hoping to make 2.6.20 an 
>> easy
>> release, and held back on merging some stuff during the merge window for
>> that reason. And now we're battling something that was introduced much
>> earlier..
>>
>> Now, practically speaking this isn't likely to affect a lot of people, 
>> but
>> it's still a worrisome problem, and we've had "top people" looking at it.
>> And they'll continue, but xmas is coming.
>>
>> In the meantime, we'll continue with the stabilization, and this mainly
>> does some driver updates (usb, sound, dri, pci hotplug) and ACPI updates
>> (much of the latter syntactic cleanups). And arm and powerpc updates.
>>
>> Shortlog appended.
>>
>> For developers: if you sent me a patch, and I didn't apply it, it was
>> probably just missed because I concentrated on other issues. So pls
>> re-send.. Unless I explicitly told you that I'm not going to pull it due
>> to the merge window being over, of course ;)
>>
>>                 Linus
> 
> [shortlog snipped]
> 
> As already reported multiple times, including at -rc1 time...
> 
> still need this libata-sff.c patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw
> 
> to have my root device detected, ata_piix probe would otherwise
> fail as described in this thread:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0612.0/0690.html

I've got a patch that should work for those cases.  Alan's patch 
contained some bugs.

	Jeff



