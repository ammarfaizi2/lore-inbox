Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFJKRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTFJKRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:17:16 -0400
Received: from mail.ithnet.com ([217.64.64.8]:8209 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261825AbTFJKRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:17:01 -0400
Date: Tue, 10 Jun 2003 12:30:15 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030610123015.4242716e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
	<20030609171011.7f940545.skraw@ithnet.com>
	<Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003 21:38:16 -0400 (EDT)
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> On Mon, 9 Jun 2003, Stephan von Krawczynski wrote:
> 
> > During the whole testing with SMP I recognised that the tar-verify always
> > brought up "content differs" warnings. Which basically means that the
> > filesize is ok but the content is not. As there might be various causes for
> > this (bad tape, bad drive, bad cabling) I did not give very much about it.
> > But it turns out there are no more such warnings when using an UP kernel
> > (on the same box with the complete same hardware including tapes).
> > 
> > >From this experience I would conclude the following (for my personal test
> > case):
> 
> Can you also try this with 2.5?

Uh, do I trust Linus ? ;-) Well, probably I am going to take a look. The whole
story eats a lot of time as I have to deal with GBs of data for every single
test.

> > 1) aic-driver has problems with smp/up switching (meaning crashes when
> > trying an SMP build with nosmp). This is completely reproducable.
> 
> Can you also try an SMP kernel with noapic?

Can you clarify? Do you mean options "nosmp noapic" or just "noapic" on SMP
kernel?

> > 2) aic-driver (almost no matter what version) has problems with SMP setup
> > and tape drives. Obviously data integrity is not given. This is completely
> > reproducable in my test setup.
> 
> I have had problems with symmetric interrupt handling but can normally get 
> it working with noapic. And no it doesn't appear to be an interrupt 
> routing problem on my box (If it is someone please clearly state what the 
> exact problem is to me)

Hm, my question is: if it were exclusively an apic problem, why do other
controllers (in a filesystem environment) work flawlessly. Maybe the driver and
apic simply have differing opinions in certain race cases, but that does not
mean that apic is always to blame, does it?

Regards,
Stephan
