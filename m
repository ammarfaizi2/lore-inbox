Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSLZDMN>; Wed, 25 Dec 2002 22:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSLZDMN>; Wed, 25 Dec 2002 22:12:13 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:12818 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S261894AbSLZDML>; Wed, 25 Dec 2002 22:12:11 -0500
Date: Wed, 25 Dec 2002 19:20:25 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: Bubba <bp@dynastytech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CPU failures ... or something else ?
In-Reply-To: <200212252002.24898.bp@dynastytech.com>
Message-ID: <20021225191831.W6873-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, last post - but here are some more details.  First, the error produced
is:

Message from syslogd@localhost at Mon Dec 23 22:44:16 2002 ...
localhost kernel: CPU 1: Machine Check Exception: 0000000000000004

Message from syslogd@localhost at Mon Dec 23 22:44:17 2002 ...
localhost kernel: Bank 4: b200000000040151

Message from syslogd@localhost at Mon Dec 23 22:44:17 2002 ...
localhost kernel: Kernel panic: CPU context corrupt


So, using the parsemce.c program that exists, I run:


usage:  parsemce [options]
  options:  -V <version number>
            -e <MCE status code>
            -b <bank number>
            -s <bank status code>
            -a <bank address>
            -f <filename, with MCE dump inside>
            -i <get MCE dump from stdin>


So:


./a.out -e 0000000000000004 -b 4 -s b200000000040151

(assuming MCE status code is 0000000000000004 and bank status code is
b200000000040151 )

and I get this as a result:

Status: (4) Machine Check in progress.
Restart IP invalid.

Any ideas what "Restart IP invalid" means ?

thanks.



On Wed, 25 Dec 2002, Bubba wrote:

> try turning off the Machine Check Exception in the kernel as it is just buggy
> on some machines, not necessarily a bug in the kernel, or without
> recompiling, use the kernel param "nomce"
>
> On Wednesday 25 December 2002 19:53, Josh Brooks wrote:
> > Hello,
> >
> > I have a dual p3 866 running 2.4 kernel that is crashing once every few
> > days leaving this on the console:
> >
> >
> > Message from syslogd@localhost at Tue Dec 24 11:30:31 2002 ...
> > localhost kernel: CPU 1: Machine Check Exception: 0000000000000004
> >
> > Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> > localhost kernel: Bank 4: b200000000040151
> >
> > Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> > localhost kernel: Kernel panic: CPU context corrupt
> >
> >
> >
> > Word on the street is that this indicates hardware failure of some kind
> > (cpu, bus, or memory).  My main question is, is that very surely the
> > culprit, or is it also possible that all of the hardware is perfect and
> > that a bug in the kernel code or some outside influence (remote exploit)
> > is causing this crash ?
> >
> > Basically, I am ordering all new hardware to swap out, and I just want to
> > know if there is some remote possibility that my hardware is actually just
> > fine and this is some kind of software error ?
> >
> > ALSO, I have not been physically at the console when this has happened,
> > and have not tried this yet, but whatever that thing is where you press
> > ctrl-alt-printscreen and get to enter those post-crash commands - do you
> > think that would work in this situation, or does the above error hard lock
> > the system so you can't do those emergency measures ?
> >
> > thanks!
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>

