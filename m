Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUFWPyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUFWPyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUFWPyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:54:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10918 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265212AbUFWPy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:54:29 -0400
Date: Wed, 23 Jun 2004 17:54:13 +0200 (CEST)
From: Lukasz Michal Rak <L.Rak@elka.pw.edu.pl>
To: abhijit <slashdev@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: do_gettimeofday( ) precision?
In-Reply-To: <7c07cd69040623082311234157@mail.gmail.com>
Message-ID: <Pine.GSO.4.58.0406231747300.2009@mion.elka.pw.edu.pl>
References: <7c07cd69040623082311234157@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, abhijit wrote:

> hello,
>
> the comment on top of do_gettimeofday( ) [arch/i386/kernel/time.c] says:
>
> /*
>  * This version of gettimeofday has microsecond resolution
>  * and better than microsecond precision on fast x86 machines with TSC.
>  */
> void do_gettimeofday(struct timeval *tv)
> {
> ...
>
> but the code below limits usec to <= 1000000. so isn't the resolution
> not limited to microsec even on TSC capable boxes?
>
> if one wants higher resolution (for timestamping etc.) whats the preferred
> way?
>
> thanks
> abhijit

	Hi!

 I think you are right that do_gettimeofday() is limited to microsec even
on boxes with TSC register. This function returns only seconds and
microseconds so you won't get better resolution with it. I don't know the
way how to do it, but I wonder about precision of such mechanism (if any
exists).
 Regards,

		Lukasz
