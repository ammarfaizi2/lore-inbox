Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVIVJqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVIVJqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVIVJqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:46:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9354 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030243AbVIVJqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:46:20 -0400
Date: Thu, 22 Sep 2005 11:46:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] Rework image freeing
Message-ID: <20050922094608.GA1773@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz> <200509220053.45358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509220053.45358.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -
> > -/**
> > - *	calc_nr - Determine the number of pages needed for a pbe list.
> > - */
> > -
> > -static int calc_nr(int nr_copy)
> > -{
> > -	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
> > -}
> 
> I can't see why you are going to drop this function.  Isn't it necessary any more?

I've actually decreased on-disk memory requirements by... guess what:
(nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1) factor. I do not store two
copies of page directories any more.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
