Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317844AbSG3BGh>; Mon, 29 Jul 2002 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSG3BGh>; Mon, 29 Jul 2002 21:06:37 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:40329 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317844AbSG3BGg>; Mon, 29 Jul 2002 21:06:36 -0400
Message-ID: <000f01c23766$a04259d0$2c060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "James Bourne" <jbourne@mtroyal.ab.ca>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
References: <Pine.LNX.4.44.0207291838160.20963-100000@skuld.mtroyal.ab.ca>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Date: Mon, 29 Jul 2002 20:15:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 29 Jul 2002, Andrew Theurer wrote:
>
> > On Monday 29 July 2002 4:28 pm, Alan Cox wrote:
> > > Its quite possible the irq routing ought to be smarter, at the moment
> > > I'm not sure of the best approaches.
> >
> > Agreed, we need some sort of irqbalance, and I intend to test with
Ingo's and
> > Andrea's approaches. With that addition, I may even see an improvement
with
> > hyperthreading. But for an rc release, I think it would be prudent to
revert
> > the "new code" for default hyperthreading behavior, and attack the whole
> > problem in 2.4.20 or later release.
>
> Ingo Molnars patches for .17 and .18 worked
> well for us, and did balance the ints load across all the CPUs very well.
>
> You can find the patches I used agains 2.4.18 at
> http://www.hardrock.org/kernel/
>
> BTW, this was on a production box for approximately one month,
> then the box mysteriously crashed.  Due to the fact that our load wasn't
> utilizing the hyperthreading that much I removed acpismp=force from the
> boot string.
>
> The are balanced across the 2 real CPUs.

Thanks for the info.  Did you get any performance results for before and
after?  I did try Ingo's patch a while back, and I experienced about a 8%
drop in performance.  I did not have hyperthreading on, just a simple case
comparing balance to no balance.  The overhead of the ioapic programming was
too high.  Increasing the time between reroutes by 20 got me back to the
same performance as no balancing at all.  I intend to test his patch again,
along with Andrea's next.

-Andrew Theurer

