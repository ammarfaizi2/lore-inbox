Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVHaXvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVHaXvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHaXvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:51:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59520 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932145AbVHaXvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:51:00 -0400
Date: Thu, 1 Sep 2005 01:50:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: akpm@osdl.org, joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: RE: FW: [RFC] A more general timeout specification
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407>
Message-ID: <Pine.LNX.4.61.0509010136350.3743@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:

> I cannot produce (top of my head) any other POSIX API calls that
> allow you to specify another clock source, but they are there,
> somewhere. If I am to introduce a new API, I better make it 
> flexible enough so that other subsystems can use it for more stuff
> other than...

So we have to deal at kernel level with every broken timeout specification 
that comes along?

> >Why is not sufficient to just add a relative/absolute version,
> >which convert the time at entry to kernel time?
> 
> ...adding more versions that add complexity and duplicate
> code in many different places (user-to-kernel copy, syscall entry 
> points, timespec validation). And the minute you add a clock_id
> you can steal some bits for specifying absolute/relative (or vice
> versa), so it is almost a win-win situarion.

What "more versions" are you talking about? When you convert a user time 
to kernel time you can automatically validate it and later you can use 
standard kernel APIs, so you don't have to add even more API bloat.

bye, Roman
