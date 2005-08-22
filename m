Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVHVWTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVHVWTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVHVWT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:19:27 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:3976 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751349AbVHVWTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:19:14 -0400
To: gnome boxer <gnome.boxer@gmail.com>
Cc: roucaries bastien <roucaries.bastien@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.10-2.6.13-rc4 hang reboot from linux(not from
 windows or from BIOS),but 2.6.8 and 2.6.9 haven't
References: <605adbb05081907323d3bd70c@mail.gmail.com>
	<195c7a900508190807504a988a@mail.gmail.com>
	<605adbb05081908137d6c8ed7@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 Aug 2005 03:52:58 -0600
In-Reply-To: <605adbb05081908137d6c8ed7@mail.gmail.com> (gnome boxer's
 message of "Fri, 19 Aug 2005 23:13:11 +0800")
Message-ID: <m1irxyti11.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gnome boxer <gnome.boxer@gmail.com> writes:

> 2005/8/19, roucaries bastien <roucaries.bastien@gmail.com>:
>> On 8/19/05, gnome boxer <gnome.boxer@gmail.com> wrote:
>> > I use fedora core 4,when I rebooted from linux(not from windows or
>> > BIOS),it will hang after the system POST before grub display the stage
>> > 1.5 on the screen,so I must reboot again from there using CRTL+ALT+DEL
>> >
>> > I don't know whether this belongs to grub or belongs to the linux
>> > reboot changes from 2.6.8 and 2.6.9
>> 
>> did you try to add to the kernel command line reboot=cold or
>> reboot=bios or reboot=hard.
>> 
> I tried the reboot=c reboot=b reboot=s
>
> They all have this
>
>
>
>> Seems your bios reboot routine is buggy. The preevious option are workarround.
>
> I think it's linux's reboot routine's fault 

Not terribly likely as the reboot does occur.  It looks more
like one of the drivers is leaving hardware in a state that
the BIOS cannot deal with it.

My gut feel says kexec one linux kernel from another would
be a quick way to check for the move obvious driver problems
in this area.

More simply might be to boot a minimal kernel with just
your root filesystem drivers and then keep adding drivers
until you have a kernel that fails.

The SMP reboot path did change in 2.6.10 but only very slightly.

Eric

