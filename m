Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbTFWSqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbTFWSqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:46:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32269 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266101AbTFWSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:45:41 -0400
Subject: Re: O(1) scheduler & interactivity improvements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1056385266.1968.22.camel@athena.fprintf.net>
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com>
	 <3EF6B5D4.10501@aitel.hist.no>
	 <1056363509.587.13.camel@teapot.felipe-alfaro.com>
	 <1056385266.1968.22.camel@athena.fprintf.net>
Content-Type: text/plain
Message-Id: <1056394770.587.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 20:59:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 18:21, Daniel Gryniewicz wrote:
> > So then, why I can easily starve the X11 server (which should be marked
> > interactive), Evolution or OpenOffice simply by running "while true; do
> > a=2; done". Why don't they get an increased priority boost to stop the
> > from behaving so jerky?
> 
> You're own metric will kill you here.  You're while true; loop is
> running in the shell, which is interactive (it has accepted user in put
> in the past) and can therefore easily starve anything else.  You need a
> an easy way to make an interactive process non-interactive, and that's
> what these threads are all about, making interactive threads
> non-interactive (and the other way around) in a fashion that maximises
> the user experience.  A history of user input is not necessarily a good
> metric, as many non-interactive CPU hogs start out life as interactive
> threads (like your loop above).

OK, replace "while true; ..." with a parallel kernel compile, for
example, and the effect, on a 700Mhz laptop, is nearly the same: you can
easily starve XMMS, and X11 feels jerky. Changing between virtual
desktops in KDE produces the same effect, also.

