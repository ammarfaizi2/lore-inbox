Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTFRKwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTFRKwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:52:07 -0400
Received: from mail.ithnet.com ([217.64.64.8]:40714 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265144AbTFRKwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:52:04 -0400
Date: Wed, 18 Jun 2003 13:05:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: stoffel@lucent.com, gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       willy@w.ods.org, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030618130533.1f2d7205.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003 17:47:02 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> 
> On Fri, 13 Jun 2003, Stephan von Krawczynski wrote:
> 
> > Hello all,
> >
> > this is the second day of stress-testing pure rc8 in SMP, apic mode. Today
> > everything is fine, no freeze, no data corruption.
> >
> > current standings:
> >
> > 2 days continuous test, one file data corruption on day 1
> 
> 
> What kind of data corruption and what tests are you doing ? (sorry if you
> already mentionad that on the list)

Todays score:

7 days continuous test
one file data corruption on day 1
one file data corruption on day 4
two file data corruptions on day 6
 
Test is performed as follows:

around 70-100 GB of data is transferred to a nfs-server with rc8 onto a RAID5
on 3ware-controller.
The data is then copied via tar onto a SDLT drive connected to an aic
controller.
Afterwards the data is verified by tar.

Since rc8 this runs stable (froze before during the first day).
Whats left is that the verify done failes sometimes (see above). It does not
look like a write error to tape, because retrying the verify cycle the errors
occur in other files most of the time (or even none at all). It seems reading
back is the problem. I doubt the problem lies on the 3ware side, because this
would mean you cannot use it at all (there should be errors all over other
actions as well then).
Most of the several files tar'ed are beyond the 2 GB file size. They vary from
around 100MB upto about 15 GB per file, around 70 GB minimum summed up.
Of course I exchanged the tapes and the drive. Didn't get better.

Regards,
Stephan
