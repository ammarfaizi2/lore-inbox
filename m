Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTFJQ6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTFJQ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:58:32 -0400
Received: from mail.ithnet.com ([217.64.64.8]:6672 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263487AbTFJQ6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:58:30 -0400
Date: Tue, 10 Jun 2003 19:11:31 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030610191131.6c25762e.skraw@ithnet.com>
In-Reply-To: <23050000.1055259511@caspian.scsiguy.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<23050000.1055259511@caspian.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 09:38:31 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> I never said that it wasn't serios, I just haven't seen any indication
> that this problem is caused by my driver.  There is a big difference.
> If your complaint is that I typically help people to solve their problems
> *off-list*, then I'm sorry if that offends your sensibilities.

It does not offend my sensibilities, it is simply damaging the available
information about typical problems and their solving. If you don't do it open,
there is no way for others to follow your thoughts and debugging and therefore
you are confronted hundred times with the same questions. People have no choice
but asking you, because your debugging cases are hidden.

> I personally don't think that I need to CC a million people while I'm
> passing back various debugging information and asking for new output.  Its
> just a lot of noise for the majority of people on the linux-kernel list.

Keep in mind the broad user base of aics. Compared to other stuff in the kernel
your messages may be a whole lot more interesting to listening LKML readers
than other threads.
 
> I'm just sick of being blamed for anything that goes wrong on any system
> that happens to have an aic7xxx controller in it.  99% or the time its
> not my fault, but I suppose since I debug and resolve these issues off
> list for people that contact me, the general assumption is that these
> issues are the aic7xxx driver's fault.

No, you produce your own problem. You cannot help every single who has a
problem around his box/aic. This is impossible. So you have to create a
valuable information basis others can read and think about. This is most simply
done by debugging problems _openly_.

> >> a buffer layer bug, or a filesystem bug.
> >
> > /dev/tape with a filesystem? Have you read what we are talking about?
> 
> Where did you get the data to place on the tape?  /dev/zero?

Don't be silly. If reading a file from some hd would be a problem in itself,
then we could all go home and have a beer. You are talking about the minimum
requirement for an os.

> >>  When testing our drivers against RHAS2.1 we found that the stock
> >> kernel had data corruption issues very similar to what your are talking
> >> about when run on very fast, hyperthreading, SMP machines.  The data
> >> corruption occurred with any SCSI controller we tried, regardless of
> >vendor.
> >
> > My question is: is it solved?
> 
> My understanding is that it was fixed in 2.4.18 level kernels, but since
> I don't know the root cause of the corruption, it could have just been
> made more difficult to reproduce.

Can you point to some URL where information about this is available?

> > This is not the first discussion about an instability in aic.
> 
> I'm not talking about *every case of aic7xxx driver instability*, I'm
> talking about *this particular case* of driver instability.  Problems
> that to the naive user look similar are typically not.

Sorry, I should have said: "This is not the first discussion about an
instability in aic between you and me". 

> > Justin, this is nothing quite serious, I just mentioned it for a feedback
> > to something _simple_.
> 
> It's the only thing you've mentioned that I have enough information to
> look at.

No, it is only the most simple one. Unfortunately scsi-driver development is
everything but simple for the standard problem case. It requires the ability to
set up equipment just like the discussed case for reproduction of the problem.
Of course only for cases the author cannot reproduce inside his software via
brain.
All information needed to reproduce the main problem is available in this
thread.

> > What exactly is "elsewhere" if your data is bogus when tar'ing onto
> > /dev/tape via aic and it is completely ok when tar'ing into a file via
> > reiserfs/3ware ? There is not really much left between tar and the
> > aic-driver and the tape.
> 
> I suggest you go browse the code that is exercised by such an activity
> before you say that.

What kind of a statement is this? I spent days for reproduction of the error
case, every single test takes something from 3,5 to 24 hours. And you tell me
"well, guy, if you want to know what I know go ahead and read my code", well
knowing that at least 50% of the knowledge is not in the code but in the
surrounding material you read to get where you are. I don't want to become scsi
maintainer, I want to solve a problem - for me _and_ for others (and this is
why I do it openly).
I really have not understood what you want, besides not being spoken to.
If I were you I would try to _prove_ that it is _not_ my problem, in best by
finding the real problem. Unfortunately I (and some others) do have the
impression that you simply live by the idea that as long as nobody can _prove_ 
your code has a problem, there is no problem.
This is in fact the bofh lifestyle that works for you (as long as you do not
meet an equally skilled person), but not for the users (spell "rest of us").

Back to the facts:
Simple question: you say its not a problem inside the driver. Ok. Question: how
to you prove that? Can you specify a test setup (program or something) I can
check to see that there is no problem with the general SMP tape usage of the
aic driver? I mean you must have seen something working, or not?

Regards,
Stephan

