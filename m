Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289368AbSAOCS5>; Mon, 14 Jan 2002 21:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289366AbSAOCSs>; Mon, 14 Jan 2002 21:18:48 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:31437 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S289361AbSAOCSi>; Mon, 14 Jan 2002 21:18:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
Date: Mon, 14 Jan 2002 21:18:36 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
In-Reply-To: <Pine.LNX.4.40.0201141748570.1233-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201141748570.1233-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115021837.4A63969E@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 08:50 pm, Davide Libenzi wrote:
> On Mon, 14 Jan 2002, Ed Tomlinson wrote:
> > On January 13, 2002 10:45 pm, Davide Libenzi wrote:
> > > On Sun, 13 Jan 2002, Ed Tomlinson wrote:
> > > > With pre3+H7, kernel compiles still take 40% longer with a setiathome
> > > > process running at nice +19.  This is _not_ the case with the old
> > > > scheduler.
> > >
> > > Did you try to set MIN_TIMESLICE to 10 ( sched.h ) ?make bzImage with
> > > setiathome running nice +19
> >
> > This makes things a worst - note the decreased cpu utilizaton...
> >
> > make bzImage  424.33s user 32.21s system 48% cpu 15:48.69 total
> >
> > What is this telling us?
>
> Doh !
> Did you set this ?
>
> #define MIN_TIMESLICE  (10 * HZ / 1000)

I set:

#define MIN_TIMESLICE  10

Now I am tring 

#define MIN_TIMESLICE  1

which, looksing at monitors, gives about 80% cpu to the compile

Ed Tomlinson










