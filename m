Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUI1Ewm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUI1Ewm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 00:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUI1Ewm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 00:52:42 -0400
Received: from digitalimplant.org ([64.62.235.95]:26580 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267526AbUI1Ewk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 00:52:40 -0400
Date: Mon, 27 Sep 2004 21:52:31 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: suspend/resume support for driver requires an external firmware
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD579B@pdsmsx403>
Message-ID: <Pine.LNX.4.50.0409272142250.24893-100000@monsoon.he.net>
References: <3ACA40606221794F80A5670F0AF15F8403BD579B@pdsmsx403>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Sep 2004, Zhu, Yi wrote:

> Oliver Neukum wrote:
> >> Do you suggest before user echo 4 > /proc/acpi/sleep, [s]he must do
> >> something like cat /path/of/firmware > /proc/net/ipw2100/firmware?
> >
> > Yes.
>
> I prefer it could be transparent to users.

Then put it in a script. There are other things that need to be done,
based on user policy, during suspend and resume transitions. See the
suspend scripts that Nigel maintains for swsusp2 for examples of this. In
an ideal world (i.e. the future), users will not be echo'ing values into a
proc or sysfs file; they will be running a 'meta-script' or clicking a
button on their desktop or just closing the lid to their laptop to
suspend.

To that end, we need something like an /etc/power/ directory with scripts
that a suspend script or program runs on power state transitions. That
way policy and device-specific items can easily be dropped in there, and
transparency can be achieved that way.


	Pat
