Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTBCONy>; Mon, 3 Feb 2003 09:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbTBCONy>; Mon, 3 Feb 2003 09:13:54 -0500
Received: from linuxpc1.lauterbach.com ([213.70.137.66]:57778 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S266356AbTBCONx>; Mon, 3 Feb 2003 09:13:53 -0500
Message-Id: <5.2.0.9.2.20030203151616.019a5900@mail.lauterbach.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 03 Feb 2003 15:23:17 +0100
To: bill davidsen <davidsen@tmr.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not
  2.4.x,
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-02-02 15:40:33 Bill Davidsen wrote:
>On Wed, 29 Jan 2003, David C Niemi wrote:
>
> >
> > On Tue, 28 Jan 2003, David S. Miller wrote:
> > >    From: kuznet@ms2.inr.ac.ru
> > >    Date: Wed, 29 Jan 2003 02:56:41 +0300 (MSK)
> > >
> > >    Hey! Interesting thing has just happened, it is the first time when I
> > >    found the bug formulating a senstence while writing e-mail not while
> > >    peering to code. :-)
> > >
> > > Congratulations :-)
> >
> > Just to confirm, this fix works for me as well.
> >
> > ...
> > > Indeed, this bug exists in 2.4 as well of course.
> > >
> > > This bug is 2.4.3 vintage :-)  It got added as part of initial
> > > zerocopy merge in fact.
> >
> > Odd, then, that it I was unable to reproduce the SSH hangs under 2.4.18
> > even once, despite heavily using it for several days under the same
> > circumstances.  Is there any reason 2.4.x would be better able to 
> recover?
> > 2.5.59 with the fix seems to feel a bit less balky than 2.4.18 without the
> > fix, so it seemed to me that 2.4.18 had some way of recovering at the cost
> > of a several second pause in the session.
>
>The problem which I have been seeing with some regularity is not the hang
>you describe (I see that infrequently) but rather a hang after I exit an
>ssh connection. I open several dozen windows at a time to a cluster when I
>do admin, and when I close almost always at least one doesn't drop without
>"~." to help. So far in a hour I haven't seen that.

That's some internal problem in OpenSSH, can be seen on Solaris as well. 
Can be easily reproduced in a ssh session:

nohup sleep 60 &
logout

The ssh session will terminate only after the sleep exited.

Franz.


