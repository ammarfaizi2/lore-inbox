Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUCXVKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCXVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:10:39 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:50329 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261928AbUCXVK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:10:28 -0500
Date: Thu, 25 Mar 2004 05:06:06 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Jonathan Sambrook" <jonathan.sambrook@dsvr.co.uk>,
       "Pavel Machek" <pavel@suse.cz>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Cc: linux-kernel@vger.kernel.org,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net> <20040324151831.GB25738@atrey.karlin.mff.cuni.cz> <20040324202259.GJ20333@jsambrook>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5dwwgzi4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040324202259.GJ20333@jsambrook>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 20:22:59 +0000, Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk> wrote:

> At 16:18 on Wed 24/03/04, pavel@suse.cz masquerading as 'Pavel Machek' wrote:
>> Hi!
>>
>> > > Except when it is not in syslog, because it was after atomic copy or
>> > > before atomic copy back. swsusp is pretty unique in this respect.
>> > >
>> >
>> > And I would consider an error that happens after atomic copy critical. If
>> > this happens all attempts to draw progress bar, etc. should be stopped and
>> > suspend should probably abort as well.

swsusp2 aborts and reads back the kernel and process data, it recovers even
when hitting ESC just before powerdown.

>>
>> Well, not all printks() are errors this hard. And at some points, it
>> is no longer possible to abort (after pagedir is on disk, its okay to
>> panic (machine will resume normally after that), but its not okay to
>> simply return. You could fix signature then return, but it would be hard).

It is _utterly_ unacceptable to fail  during suspend. You might as well take
a sledge hammer to kill the box!

Suspend is a mechanism to suspend the system transparently and
_NOT_EVER_ impairing the system. There can be NO_COMPROMISE and
NO_EXCUSE. I walk out of my office suspending the machine and resuming it
in front of my client it can't ever fail, or am I an idiot to advocate linux?

If I would be willing to accept failure I would not spend my time here and
utilize M$'s  incarnation of an architectural idiocy.

>>
>> > What happens if swsusp1 gets such an error during atomic phase? Will it
>> > continue or abort? If it continues I would imagine user not noticing the
>> > message it it flashes the split second before the box powers off.
>>
>> It continues. Fortunately powerdown takes enough time on most machines
>> that messages can be readed ...
>
>> if you pay attetion.
>
> Which is not a normal usage scenario.

Right, because nobody pays attention. If you step on the brake pedal driving
your car these brakes better work or you may be well worse of than dead
... just in case you ran over a kid...

>
> Common scenario:
>
>  suspend machine then go home/to bed

Worse, I suspend 3 networked machines from a notebook via ssh,
tear out the network cable from the notebook and run out or go to
bed. NFS crossmounts still make me trouble at times...

>
>
>  BTW Pavel I'm not arguing that the code has to stay in without
>  modification
>  (e.g. massively stripped down or whatever). But this is one place where
>  kernel code is a lot closer to Joe Enduser's awareness than is usually
>  the case, so IMUO, the priorities shift.
>

First we have to agree on what the objectives are, the code will follow.

And eventually one has to combine the superiority of linux with the
simplicity/primitivity of M$, which I am btw still recovering from.

Michael
