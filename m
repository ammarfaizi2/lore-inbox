Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWHBUaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWHBUaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWHBUaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:30:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38547 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932228AbWHBUaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:30:22 -0400
Date: Wed, 2 Aug 2006 22:30:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] swsusp: Fix mark_free_pages
Message-ID: <20060802203005.GF8124@elf.ucw.cz>
References: <200608021842.21774.rjw@sisk.pl> <200608021848.54374.rjw@sisk.pl> <1154548279.7232.34.camel@localhost.localdomain> <200608022212.48293.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608022212.48293.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Looks good to me (ACK).

>  			if (page) {
> -				long *src, *dst;
> -				int n;
> +				void *ptr = page_address(page);;

You probably want to remove one of ";"s.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
