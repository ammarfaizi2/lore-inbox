Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbQKANuu>; Wed, 1 Nov 2000 08:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbQKANuk>; Wed, 1 Nov 2000 08:50:40 -0500
Received: from [208.129.208.52] ([208.129.208.52]:16901 "HELO
	empire.virusscreen.com") by vger.kernel.org with SMTP
	id <S130917AbQKANuV>; Wed, 1 Nov 2000 08:50:21 -0500
Message-ID: <001301c0440c$fe6879d0$43bc0497@pcdavide>
From: "Davide Libenzi" <davidel@xmail.virusscreen.com>
To: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>, <anonymos@micron.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200011011327.HAA204292@tomcat.admin.navo.hpc.mil>
Subject: Re: 1.2.45 Linux Scheduler
Date: Wed, 1 Nov 2000 15:06:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
To: <anonymos@micron.net>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 01, 2000 2:27 PM
Subject: Re: 1.2.45 Linux Scheduler


> ---------  Received message begins Here  ---------
>
> >
> > In the Linux scheduler they use a circular queue implementation with
round
> > robin. What is the advantage of this over just using a normal queue with
a
> > back and front. Also does anyone know what a test plan for such a design
> > would even begin to look like. This is a project for a proposal going
around
> > in my neighborhood and I am wondering why in the world someone would
want to
> > modify the Linux scheduler to this extent.
>
> This is not an authoritive answer but:
>
> It's simple, and fast. Locks only needed when adding/removing
> entries.
>
> It is also nearly optimum when the queue only has 5 (or so) number of
> entries. It will not be optimum if there are 32/64 CPUs with 120 or more
> runnable entries. There are other schedulers available that may do a
> better job for that situation.

I don't know who runs Linux w/ 32/64 CPUs and w/ 120 active procs but
if someone on earth exist ... :

http://www.mycio.com/davidel/lk/adapt-sched-v3.0-2.2.14.gz



- Davide


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
