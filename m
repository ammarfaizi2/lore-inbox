Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVKVSps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVKVSps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVKVSpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:45:47 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:8714 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965100AbVKVSpr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:45:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJxDJzEa+PODc6fen05n1lO9MgPOhhxHJaYYmEuyi51BVZVjVBdFoomXbdqRi4yHK/7Iz0Hyc4RiiaFvRH1WjYRvk9ZRY300I3OvXtjl23QCFPGv4t4sATNyX1sLGSom438X+2xkJCp4IN0iwRUiKA28aF0FI2Qf63L4c8NtE6I=
Message-ID: <d120d5000511221045x35cfb416q67c855414b896315@mail.gmail.com>
Date: Tue, 22 Nov 2005 13:45:46 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
In-Reply-To: <20051122174643.GB1752@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87zmoa0yv5.fsf@obelix.mork.no>
	 <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
	 <20051119234850.GC1952@spitz.ucw.cz>
	 <200511220026.55589.dtor_core@ameritech.net>
	 <871x19giuw.fsf@obelix.mork.no> <20051122174643.GB1752@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> [Please Cc me if you want fast reply.]
>
> > > Swsusp: do not time-out when stopping tasks while resuming
> > >
> > > When stopping tasks during esume process there is no point of
> > > eastablishing a timeout because teh process is past the point
> > > of no return; there is no possible recovery from failure. If
> > > stopping tasks fails resume is aborted and user is forced to
> > > do fsck anyway.
> >
> > If a clueless users voice counts for anything: I couldn't agree more.
> >
> > A failed resume is a near catastrophy if you use and trust swsusp. And
> > how could it ever be useful if you don't?
>
> Failed resume is only as bad as powerfail.
>

So? I don't like powerfails either. Could you please answer this
question - what pros of having resume process time out do you
envision? What problems does it help to solve?

> > Maybe that even would give me a chance to fix some hardware problem
> > causing the timeout, and then retry the resume.
>
> ..while doing resume few times, trying to change hw config to make it
> resume is _way_ more dangerous.

And still we have to do our best to support it. There is USB,
Firewire, Docking station that may appear/disappear while box is
suspended and we absolutely need to support this. Requiring that
hardware configuration has to be frozen between suspend/resume cycles
will not get us far.

--
Dmitry
