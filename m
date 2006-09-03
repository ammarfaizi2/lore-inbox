Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWICSYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWICSYb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 14:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWICSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 14:24:31 -0400
Received: from rrcs-24-227-114-150.se.biz.rr.com ([24.227.114.150]:65171 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S932082AbWICSYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 14:24:30 -0400
Date: Sun, 3 Sep 2006 14:21:23 -0400 (EDT)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Matthias Hentges <oe@hentges.net>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
 easily reproducable
In-Reply-To: <200609031555.24901.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.44.0609031417060.13873-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2006, Denis Vlasenko wrote:

> On Sunday 03 September 2006 01:49, shogunx wrote:
> > > > > Well, it just crapped out on me again :(
> > > > >
> > > > > Sep  2 23:36:13 localhost kernel: NETDEV WATCHDOG: eth2: transmit timed
> > > > > out
> > > > > Sep  2 23:36:13 localhost kernel: sky2 hardware hung? flushing
> > > > >
> > > > > Only a rmmod / modprobe cycle helps at this point.
> > > >
> > > > Really?  What is the error condition causing it?  On my friends lap, which
> > > > has an integrated sky2, his drops out with a full sustained TX...
> > > > uploading to another box for example, at about 4-8MB of transfer.  The
> > > > fix in his case is ifdown eth0 && ifup eth0.  I have
> > > > yet to see the error occur at all on my ExpressCard device, either with
> > > > 2.6.18-rc5 or 2.6.17.5.  I built the rc5 as a preemptive measure, but I
> > > > cannot get it to fail under any conditions.
> > > >
> > >
> > > I have yet to find a reproduceable way to trigger the bug but I'll try a
> > > few things tomorrow.
> > > Currently it appears to be completely ranom. I've loaded the driver w/
> > > debug=10, maybe it'll give some clues.
> >
> > Ack.  Awaiting more info.  I pushed it pretty hard last night with both
> > kernel revisions, scp'ing cd iso images and kernel tarballs back and forth
> > across the interface, and could not get it to lock.  I am using a 88E8053
> > chipset.  I'll ask my friend what chipset his is.  Perhaps its a
> > different bug that is hitting you now...
>
> scp isn't "pushing very hard". It takes some time to do ssh crypto
> and even if your CPU is fast enough for that to be not an issue,
> scp is using TCP, which is _designed_ to not saturate links to 100.00%.

thats the condition that caused the error on my friends box... scp a large
file up over the interface in question, and watch the link dump.

>
> Give it a real hard beating with uni- and bidirectional UDP netcat flood! :)

well, there is that.  i'll give it that pounding and see what happens.

> --
> vda
>
> --
> VGER BF report: U 0.511791
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/


-- 
VGER BF report: U 0.482991
