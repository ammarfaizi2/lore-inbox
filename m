Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTEIMtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTEIMtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:49:47 -0400
Received: from mail.ithnet.com ([217.64.64.8]:63237 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263161AbTEIMtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:49:46 -0400
Date: Fri, 9 May 2003 15:02:07 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: gibbs@scsiguy.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030509150207.3ff9cd64.skraw@ithnet.com>
In-Reply-To: <20030509120659.GA15754@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003 14:06:59 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> On Fri, May 09, 2003 at 12:06:48PM +0200, Stephan von Krawczynski wrote:
>  
> > Justin, just to complete the picture: as I wrote some days ago concerning
> > your hint to "use the latest from ..." your latest driver does not complete
> > booting on (at least) my system but freezes - which I wrote to LKML. I have
> > not yet heard
> > anything about this issue. You cannot expect to include a newer driver
> > which performs obviously worse in some cases.
> > "Worse" here means "fails" and not "performs bad". Marcelos' decision on
> > the topic looks pretty reasonable to me...
> 
> What's your setup ? Are you in SMP ?

SMP PIII 1.4 GHz, dual Adaptec AIC-7899P U160/m (rev 01)

> I was hit by a lock bug introduced near
> 6.2.30, which Justin fixed recently and included in his latest driver
> (20030502). Justin suggested to me to try the NMI watchdog to find what was
> wrong and it pointed us to a spinlock problem. Have you tried to debug
> something ?

I cannot say which version of the driver it was, the only thing I can tell you
is that the archive was called aic79xx-linux-2.4-20030410-tar.gz.

> I must say that this driver seems really robust now on my setup
> (dual athlon), but perhaps your problem is of the same order and could be
> fixed easily with some help, which would be good for you and everyone else.

I can't tell, basic problem in my setup is that it seems virtually impossible
to bring some 100GB of data onto a streamer connected to the above aic. It
crashes almost every day with a freeze and no oops or other message. I am at
the moment willing to await 2.4.21 and see, and if that does not solve it, then
I will probably go back to a dual symbios controller which I used before and
never had any glitches with.
This is a system in production and not particularly useful for debugging a lot
and correspoding downtime.

Regards,
Stephan

