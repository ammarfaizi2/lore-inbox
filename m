Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUGFARw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUGFARw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 20:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGFARw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 20:17:52 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:43791 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S262322AbUGFARt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 20:17:49 -0400
Date: Tue, 6 Jul 2004 02:17:47 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <200407052352.51135.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.21.0407060020110.29315-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Jul 2004, Bartlomiej Zolnierkiewicz wrote:
> On Monday 05 of July 2004 23:08, Andries Brouwer wrote:
> 
> > Is there any advantage in going back? I don't think so.
> > The old situation was broken. People lost all data.

Yes they did and still do for example because of the reasons Bartlomiej
quoted and 

	http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-10/4682.html

but please explain what you mean exactly "they lost data"? There are many
ways to lose data and they have different severities.

I've meant partition table corruptions. When the values returned by
HDIO_GETGEO don't match what are in the partition table, [lib]parted will
rewrite all partition entries. "Fixes" them as Andrew says. This "fix"
breaks bootability if some bootloaders rely on them and in some cases
the partition starts are even moved to wrong cylinder boundaries due to
additional problems in tools using [lib]parted.
 
> According to szaka the "the new situation" is similar. :(

No. The situation in 2.6 is much more serious. Using 2.4 kernels people
lost data due to partition corruptions, but not so often, perhaps 1-2
reports a week. Using 2.6, several a day.

Are you really not aware of the seriousness of the issue? Didn't you read
the bugzilla URL's sent? LWN, Eweeks, O'Reilly, OSNews, Slashdot, Amazon
and many others discussed this 2.6 kernel problem already. Only kernel
developers aren't aware of it? :-o

> > Also "the old situation" is badly defined. The returned value differs
> > for 2.0, 2.2, 2.4, 2.6.

2.4 was slightly broken. 2.6 is much more broken than 2.4 from the
number of partition table corruptions point of view.
 
> What I'm only worried is that there might be cases when 2.4 worked
> and 2.6 doesn't which with combination with bugs in the tools cause
> "where is my data?" issue.

No need to worry ;) This is a known fact for about 6-7 weeks, at least.
But it was also reported here almost every months since last October. Now
that some major distros with 2.6 started to ship, the 2.6 HDIO_GETGEO
breakage got really confirmed.

That's why I asked several times, what did 2.6 HDIO_GETGEO fix? 

When does 2.6 work when 2.4 doesn't? 

I'm not aware of any. Nobody wrote any. 

Andries just avoids straight answers for touchy and detailed questions.

	Szaka

