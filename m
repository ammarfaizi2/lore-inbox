Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVIAJUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVIAJUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVIAJUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:20:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63363 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750830AbVIAJUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:20:33 -0400
Date: Thu, 1 Sep 2005 11:19:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: akpm@osdl.org, joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: RE: FW: [RFC] A more general timeout specification
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B03A8@orsmsx407>
Message-ID: <Pine.LNX.4.61.0509011104160.3728@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B03A8@orsmsx407>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:

> Hmm, I cannot think of more ways to specify a timeout than how
> long I want to wait (relative) or until when (absolute) and which
> is the reference clock. And they don't seem broken to me, common
> sense, in any case. Do you have any examples?

You still didn't explain what's the point in choosing different clock 
sources for a _timeout_.

> Different versions of the same function that do relative, absolute.
> If I keep going that way, the reason becomes:
> 
> sys_mutex_lock
> sys_mutex_lock_timed_relative_clock_realtime
> sys_mutex_lock_timed_absolute_clock_realtime
> sys_mutex_lock_timed_relative_clock_monotonic
> sys_mutex_lock_timed_absolute_clock_monotonic
> sys_mutex_lock_timed_relative_clock_monotonic_highres
> sys_mutex_lock_timed_absolute_clock_monotonic_highres

Hiding it behind an API makes it better?

You didn't answer my other question, let's assume we add such a timeout 
structure, what's wrong with converting it to kernel time (which would
automatically validate it).

bye, Roman
