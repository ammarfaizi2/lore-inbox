Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285246AbRLXTAp>; Mon, 24 Dec 2001 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285253AbRLXTAf>; Mon, 24 Dec 2001 14:00:35 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:49420 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285246AbRLXTAX> convert rfc822-to-8bit;
	Mon, 24 Dec 2001 14:00:23 -0500
Date: Mon, 24 Dec 2001 20:00:21 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224200021.F2461@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011224180142.E2461@lug-owl.de> <20011224181031.GA7934@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20011224181031.GA7934@localhost>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-24 19:10:32 +0100, José Luis Domingo López <jdomingo@internautas.org>
wrote in message <20011224181031.GA7934@localhost>:
> On Monday, 24 December 2001, at 18:01:42 +0100,
> Jan-Benedict Glaw wrote:
> 
> > I've got some problem with a freshly installed Debian sid system.
> > It's running with 2.4.16, 2.4.17-rc2 and 2.4.17 (the problem
> > appears on all these kernels) and something seems to break ssh.
> > 
> I don't know if this has something to do with your problem, but
> bugs.debian.org has a _long_ list of reported bugs for ssh, many of them
> with respect to ssh's X-forwarding.

Yes, I know, and it's not only connected to X forwording, but also
(this is the majority of filed bugs) with ssh's exit behaviour
when any processes where started in background. However -- I've
got this problem with the running, interactive session. If I make
the server to send more than maybe 200 byte or so, the session
will hang, with both sides sitting in select, and data on the
server's Send-Q...

> My own experience with Debian's ssh is that, sooner or later,
> X-forwarding fails, with Send-Q (or Recv-Q) in the server side
> completely full. The server side was Debian Sid, and client side was
> Debian Woody, and it happened with both a simple xclock and gkrellm (ssh
> remoteserver xclock, ssh remoteserver gkrellm).

Well, my understanding is that, if there's data in any of the queues,
these bytes should be delivered. In this case, data is *not* sent
over the wire. Is this a kernel bug? ...or is data only transmitted
if we're in position to also set the PUSH bit?

> However, interactive shells didn't seem to show this problem.

Mine does:-( And this is quite annoying, because I'm to present
some software on the box in question in some days. But, with
no ssh on a (so far) headless box, I'll face some trouble...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
