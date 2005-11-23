Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVKWKMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVKWKMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKWKMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:12:37 -0500
Received: from canardo.mork.no ([148.122.252.1]:9606 "EHLO canardo.mork.no")
	by vger.kernel.org with ESMTP id S1030385AbVKWKMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:12:36 -0500
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Organization: DoD
References: <87zmoa0yv5.fsf@obelix.mork.no>
	<200511220026.55589.dtor_core@ameritech.net>
	<20051122184739.GB1748@elf.ucw.cz> <200511222315.31033.rjw@sisk.pl>
	<20051122225120.GI1748@elf.ucw.cz>
Date: Wed, 23 Nov 2005 11:09:15 +0100
In-Reply-To: <20051122225120.GI1748@elf.ucw.cz> (Pavel Machek's message of
	"Tue, 22 Nov 2005 23:51:20 +0100")
Message-ID: <87hda3d6b8.fsf@obelix.mork.no>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

>> > Well, I do not think this problem will surface again. It is first
>> > failure in pretty long time. If it happens again, I'll take your
>> > patch.
>> 
>> If so, could you please make it printk() a message after the timeout has
>> passed?  This way the user will know what's going on at least.
>
> We do have messages there, they even tell you name of process that was
> not stopped. That's enough to debug failure quickly.

I don't think so.  The example said

 "Strange, kseriod not stopped"

This names a process that admittedly took a long time to stop, but not
the real *cause* of the failure.  There was nothing wrong with kseriod.

FWIW, debugging this was way out of my league.  I might have had a
better chance if it mentioned a short, fixed timeout.  I also noticed
that it wasn't very obvious to you either at first.  The first thought
was a failing serio driver, although that admittedly might be because
I mislead you in my attempt to pinpoint the failure.

But my first post in this thread *did* include the printk() you
mention above, so it should have been possible to debug it quickly...


Bjørn
