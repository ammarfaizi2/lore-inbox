Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbTILDGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 23:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTILDGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 23:06:24 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:4805 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S261343AbTILDGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 23:06:21 -0400
Date: Fri, 12 Sep 2003 00:06:14 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: horrible usb keyboard bug with latest tests
Message-ID: <20030912030614.GG6971@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	Andries Brouwer <aebr@win.tue.nl>,
	=?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>,
	linux-kernel@vger.kernel.org
References: <20030911125744.89506.qmail@web60207.mail.yahoo.com> <20030911134608.GN15818@vega.digitel2002.hu> <20030911233823.A2383@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030911233823.A2383@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 11:38:23PM +0200, Andries Brouwer wrote:
> On Thu, Sep 11, 2003 at 03:46:08PM +0200, Gábor Lénárt wrote:
> > On Thu, Sep 11, 2003 at 05:57:44AM -0700, Mr. Mailing List wrote:
> > > Ok, for the last few test kernels, there is a horribly
> > > annoying usb keyboard bug.  after a while in X, or
> > > just when you start putting some input, all the
> > > keyboard lights on on my msnatpro keyboard.  after
> > > that, the keycodes  are screwed up(like the left alt
> > > button)
> > > 
> > > sometimes one key would stick, like
> > > kkkkkkkkkkkkkkkkkkkkkkkkkk
> > 
> > For me too, even with a normal keyboard attached to the PS/2 keyboard port.
> > In my case it's very rare, and not a 'constant stick' but short 'pulse' of
> > the same character like displaying 'kkkkkkkkk' in my terminal even if I'm
> > sure that I didn't forget my finger on the key. OK, it's not a showstopper
> > bug, but sometimes annoying. It's 2.6.0-test3 (vanilla).
> 
> Yes, I see this too, but very infrequently.
> 
> For the 2.6 kernels key repeat is not taken from the keyboard but is
> done via a kernel timer, and clearly the code is not quite correct.
> I have not yet been able to detect it before I already
> had hit the next key but maybe somebody else can answer:

I hit it too on a PS/2 Siemens keyboard, but surprisingly I could only
verify it with both windows keys on the right side of the keyboard (the
ones between altgr and ctrl). It has never happened with a 'regular' key.

It's not very frequent but I get it about once per day or so.

I use those keys to switch consoles, instead of using
alt + [left|right] arrow; and sometimes one gets stucked and scrolls the
consoles around until I press another key.

I'm pretty sure it's not the keyboard as it never happened in 2.4, and
it's been happening since 2.5.5X or .6X IIRC (in fact I think I posted
something about it).


> When does this repeat stop?
> Does it stop because the next key has been hit?

Yes, it stops on any keypress or, if I'm running X, when it hits the X
console.


> And: does it occur more often when the machine has high load?

I have no idea, I really never thought about it but I'll put load and see
what I can find. 

Do you mean cpu load or some more complex vm load? (ie. I should "while
true; do true ; done" or "make -j bzImage" =)


Please let me know of anything else I can help you with.


Thanks,
		Alberto


