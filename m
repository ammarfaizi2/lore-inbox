Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWKMSOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWKMSOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWKMSOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:14:47 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:24585 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932508AbWKMSOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:14:46 -0500
Date: Mon, 13 Nov 2006 19:14:44 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-Id: <20061113191444.1519bdb9.khali@linux-fr.org>
In-Reply-To: <1163434826.2805.2.camel@ux156>
References: <1163280972.32084.13.camel@localhost.localdomain>
	<d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	<1163431758.23444.8.camel@localhost.localdomain>
	<d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
	<1163434455.23444.14.camel@localhost.localdomain>
	<1163434826.2805.2.camel@ux156>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 17:20:26 +0100, Johannes Berg wrote:
> On Mon, 2006-11-13 at 17:14 +0100, Stelian Pop wrote:
> > 
> > +               input_report_abs(ams_info.idev, ABS_X, x - ams_info.xcalib);
> > +               input_report_abs(ams_info.idev, ABS_Y, y - ams_info.ycalib);
> > +               input_report_abs(ams_info.idev, ABS_Z, z - ams_info.zcalib); 
> 
> Sorry about chiming in so late. When I tried to use this with neverball,
> ams_info.xcalib - x (and similar for the others) was more useful because
> of the way things are oriented. If I tilt my powerbook to the left then
> with this original code the mouse cursor moves to the right which is
> contrary to what neverball expects.
> 
> Not sure if we want to change this or not, it sort of boils down to a
> userspace issue and we could just patch neverball to have a direction
> inversion :)

For what it's worth, the hdaps driver offers a parameter to invert the
axes at the driver level. It sounds sane to me, as ideally we should be
able to detect it from the hardware, and user-space should not need to
care about hardware specific details.

-- 
Jean Delvare
