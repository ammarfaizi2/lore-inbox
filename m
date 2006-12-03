Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758395AbWLCXFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395AbWLCXFF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758779AbWLCXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:05:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34948 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1758395AbWLCXFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:05:03 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Peter Stuge <stuge-linuxbios@cdy.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, linuxbios@linuxbios.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de> <20061201204249.28842.qmail@cdy.org>
	<m164cvgvwz.fsf@ebiederm.dsl.xmission.com>
	<20061201214631.6991.qmail@cdy.org>
	<m1wt5bfces.fsf@ebiederm.dsl.xmission.com>
	<20061203170046.28314.qmail@cdy.org>
Date: Sun, 03 Dec 2006 16:03:55 -0700
In-Reply-To: <20061203170046.28314.qmail@cdy.org> (Peter Stuge's message of
	"Sun, 3 Dec 2006 18:00:46 +0100")
Message-ID: <m1r6vgeg4k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Stuge <stuge-linuxbios@cdy.org> writes:

> On Fri, Dec 01, 2006 at 04:02:03PM -0700, Eric W. Biederman wrote:
>> >> Sure, I will send it out shortly.  I currently have a working
>> >> user space libusb thing (easy, but useful for my debug)
>> >
>> > Hm - for driving which end?
>> 
>> Either.  The specific device we are talking about doesn't care.
>
> Which device do you have?

Well it is built by PLX, and from lsusb I see are:
0525:127a Netchip Technology, Inc. 

The hardware is a little rectangular pcb board a little smaller
then a business card.  Wrapped in a blue case, with vertical vents
on both of the long sides, and gets a little warm when you have been
running it for a while.  The device has what appears to be 2 normal
host to slave cables running into it.

The picture at the bottom of:
http://advdbg.org/blogs/advdbg_system/articles/64.aspx

Looks like what I have.  I'm curious about the whole plug both
ends into the host before plugging it into the client, and about
the strange target system BIOS requirements.

I think I succeeded in making it work without out that by just putting
in a reset.  It does make the whole setup of the device a pain though.

>> > The debug port isn't really supposed to be used with anything but
>> > a debug device - which can't be enumerated normally anyway.
>> 
>> It depends.  If you have a debug cable with magic ends and a
>> hardcoded address of 127 the normal enumeration doesn't work.  I
>> don't think anyone actually makes one of those.
>
> Only one of the ports on Stefan's PLX NET20DC that I had a look at
> during the LinuxBIOS symposium enumerated for me.

Very odd.  I'm pretty certain we are talking same thing.  But I do
know it has a couple of weird quirks, so maybe you just ran up against
that.

>> Debug devices are also allowed to be normal devices that just
>> support the debug descriptor.  Which is what I'm working with.
>
> Aye. I would be happy if we could get something out, as you have
> done! :) Looking forward to trying it, I hope I get my device soon.

Well at least this means after it works I can probably forget about
it and let someone else maintain the code ;)

Eric
