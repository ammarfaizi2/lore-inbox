Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVGROTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVGROTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVGROTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:19:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37257 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261764AbVGRORR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:17:17 -0400
Date: Mon, 18 Jul 2005 16:16:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: Tom Zanussi <zanussi@us.ibm.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
In-Reply-To: <1121694275.12862.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0507181607410.3743@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com>  <20050712022537.GA26128@infradead.org>
  <20050711193409.043ecb14.akpm@osdl.org>  <Pine.LNX.4.61.0507131809120.3743@scrub.home>
  <17110.32325.532858.79690@tut.ibm.com>  <Pine.LNX.4.61.0507171551390.3728@scrub.home>
  <17114.32450.420164.971783@tut.ibm.com> <1121694275.12862.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Jul 2005, Steven Rostedt wrote:

> I'm actually very much against this. Looking at a point of view from the
> logdev device. Having a callback to know to continue at every buffer
> switch would just be slowing down something that is expected to be very
> fast.

What exactly would be slowed down?
It would just move around some code and even avoid the overwrite mode 
check.

> I don't see the problem with having an overwrite mode or not. Why
> can't relayfs know this?

The point is to design a simple and flexible relayfs layer, which means 
not every possible function has to be done in the relayfs layer, as long 
it's flexible enough to build additional functionality on top of it (for 
which it can again provide some library functions).

bye, Roman
