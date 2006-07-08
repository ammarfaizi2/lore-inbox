Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWGHKmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWGHKmS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWGHKmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:42:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54200 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751083AbWGHKmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:42:18 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Arjan van de Ven <arjan@infradead.org>
To: Bojan Smojver <bojan@rexursive.com>
Cc: Jan Rychter <jan@rychter.com>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <1152353698.2555.11.camel@coyote.rexursive.com>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz>  <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 12:41:58 +0200
Message-Id: <1152355318.3120.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 20:14 +1000, Bojan Smojver wrote:
> On Sat, 2006-07-08 at 11:11 +0200, Jan Rychter wrote:
> 
> > I hate these kinds of discussions, but since no one else did, I'm going
> > to say this very openly: I don't think you should be the one "deciding"
> > this.
> 
> ACK.
> 
> Given that:
> 
> - this tie is permanent due to fundamental design disagreements
> 
> - swsusp, uswsusp and Suspend2 can coexist in the same tree
> 
> - Nigel has a track record of excellent support for his code
> 
> Why not make another kernel subsystem (Suspend2) and make Nigel
> maintainer of it? Then all this nonsense can stop and distributions and
> users can pick what they really want.

ok now a counter voice, and I'm sure I'm not going to be popular by
saying this:

Multiple all-half-working implementations is insane. It means bugs don't
get fixed, it means there isn't going to be ANY implementation that is
good enough for a broad audience. People will just switch to another one
rather than reporting and causing even the most simple bugs to get
fixed. What is worse, these suspend systems will inevitable have
different requirements on the rest of the kernel, and will thus
complicate the heck out of it for the rest of the developers. This in
turn will make *all* implementations more fragile, and everyone loses.

Very often, choice is good. but for something this fundamental, it is
not. We also don't have 2 scsi layers for example.

Now as to which it should be; I believe whatever happens it has to be
simple and robust. No fancy shnazy GUI inside the kernel, but SIMPLE.
Including well a defined and portable set of requirements on the kernel
and drivers, and done such that driver people who don't know the fine
details, can still get their drivers right.

Greetings,
   Arjan van de Ven

