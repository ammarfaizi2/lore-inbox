Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbTFWTFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbTFWTFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:05:32 -0400
Received: from mailf.telia.com ([194.22.194.25]:7154 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S266105AbTFWTFZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:05:25 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Daniel Gryniewicz <dang@fprintf.net>
Subject: Memory? Re: O(1) scheduler & interactivity improvements
Date: Mon, 23 Jun 2003 21:21:01 +0200
User-Agent: KMail/1.5.9
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       LKML <linux-kernel@vger.kernel.org>
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com> <1056385266.1968.22.camel@athena.fprintf.net> <1056394770.587.8.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056394770.587.8.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200306232121.02432.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On måndagen den 23 juni 2003 20.59, Felipe Alfaro Solana wrote:
> On Mon, 2003-06-23 at 18:21, Daniel Gryniewicz wrote:
> > > So then, why I can easily starve the X11 server (which should be marked
> > > interactive), Evolution or OpenOffice simply by running "while true; do
> > > a=2; done". Why don't they get an increased priority boost to stop the
> > > from behaving so jerky?
> >
> > You're own metric will kill you here.  You're while true; loop is
> > running in the shell, which is interactive (it has accepted user in put
> > in the past) and can therefore easily starve anything else.  You need a
> > an easy way to make an interactive process non-interactive, and that's
> > what these threads are all about, making interactive threads
> > non-interactive (and the other way around) in a fashion that maximises
> > the user experience.  A history of user input is not necessarily a good
> > metric, as many non-interactive CPU hogs start out life as interactive
> > threads (like your loop above).
>
> OK, replace "while true; ..." with a parallel kernel compile, for
> example, and the effect, on a 700Mhz laptop, is nearly the same: you can
> easily starve XMMS, and X11 feels jerky. Changing between virtual
> desktops in KDE produces the same effect, also.

And you are shure that you do not fill up your RAM?
(700MHz laptop does not sound like lots of RAM...)

* Parallel kernel compile, unlimited?
* Changing virtual desktops might be memory limited too...

Check with 'vmstat'

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
