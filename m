Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWEONeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWEONeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWEONeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:34:19 -0400
Received: from [202.125.80.34] ([202.125.80.34]:48433 "EHLO
	esnmail.esntechnologies.co.in") by vger.kernel.org with ESMTP
	id S964842AbWEONeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:34:18 -0400
Content-class: urn:content-classes:message
Subject: RE: GPL and NON GPL version modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 May 2006 19:04:06 +0530
Message-ID: <AF63F67E8D577C4390B25443CBE3B9F7092952@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPL and NON GPL version modules
thread-index: AcZ4IGdQfn8cLJMHQWSt8/uFV7mFMgAA8z6g
From: "Nutan C." <nutanc@esntechnologies.co.in>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>,
       "Fawad Lateef" <fawadlateef@gmail.com>, <jjoy@novell.com>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, <gauravd.chd@gmail.com>,
       <bulb@ucw.cz>, <greg@kroah.com>, "Shakthi Kannan" <cyborg4k@yahoo.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so now, I have a new doubt :-) Forgive me, if I am asking a lot, but
I really don't want to move ahead with the development, until and unless
I am sure I am not violating GPL. So, please bear with me. Here's the
question:

1. I developed a code which interfaces well with a proprietary OS. Now,
somebody else feels to use the same module in his Linux Kernel. So, he
comes up with a patch, which interfaces and talks to my module with my
interfaces and then makes a release with the patch. And, I would have no
idea of my module being really compatible/used in Linux Kernel. One fine
day, I would get a mail saying that I need to make my code open source.
What would be my reply?

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Monday, May 15, 2006 6:37 PM
To: Nutan C.
Cc: Jan Engelhardt; linux-kernel-Mailing-list; Fawad Lateef;
jjoy@novell.com; Mukund JB.; gauravd.chd@gmail.com; bulb@ucw.cz;
greg@kroah.com; Shakthi Kannan; Srinivas G.
Subject: RE: GPL and NON GPL version modules


On Mon, 15 May 2006, Nutan C. wrote:

> Hi Jan,
>
> So, if the proprietary code exposes an interface and if the code
within
> the GPL makes a call to that interface, will the proprietary code
become
> part of GPL. Please suggest
>

In a perfect world, all code is GPL ;)

I wont even bother with the IANAL sticker, since the lawyers I talked to
don't even know, nor would they put their career on the line for it.
Basically, you are entering a big grey area that won't be known until it
actually goes to court. And even then, it may be different for every
country.

If you compile the code as one blob, you definately violate the GPL. But
the problem comes when you have dynamic modules (and libraries).
Although
the GPL says it can't be linked, it really matters about what is
considered a derived work. That's what copyrights cover.

So just because a module or library interacts with the GPL code, is it
really a derived work? Some people say yes, others no.

Note: I don't agree with what I'm about to say, but I can see it argued
in
court this way.

Example:

Let's take Linux. I have a proprietary module that works with other
OS's.
So I want to make it work with Linux too.  So I write a GPL module that
will interact and work with my proprietary module (basically what nvidia
does).  Now is my proprietary module a derived work of Linux?  I would
find it hard to argue that it is.  For the proprietary module works with
other OS's and really only the GPL interface can be considered derived.
The module is not dependent on Linux.  But Linux may be dependent on the
module to work with some device.
(Note: I, personally, don't have a proprietary module. This is only an
example.)

Now, the question comes if your module _only_ works with Linux.  This
may
be harder to defend, since there could be an agrument that it _is_ a
derived work.

So it basically comes down to how much you think you can defend your
decision in the countries that you distribute to.  The safest bet is to
open all your code as GPL.  But if you cant, then you must weigh your
risks, and no one else can do that for you.

-- Steve
