Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRBURcC>; Wed, 21 Feb 2001 12:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129671AbRBURbw>; Wed, 21 Feb 2001 12:31:52 -0500
Received: from host217-32-138-113.hg.mdip.bt.net ([217.32.138.113]:52743 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129623AbRBURbk>;
	Wed, 21 Feb 2001 12:31:40 -0500
Date: Wed, 21 Feb 2001 17:34:41 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Giuliano Pochini <pochini@shiny.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: 128MB lost... where ?
In-Reply-To: <Pine.LNX.4.21.0102211728070.2050-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0102211730490.2050-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Tigran Aivazian wrote:

> On Wed, 21 Feb 2001, Giuliano Pochini wrote:
> 
> > 
> > Perhaps this is a faq...
> > I have a dual-800 (mb asus, no AGP) with 1GB ram,
> > but according to /proc/meminfo tells I only have
> > 900000KB. I tried "mem=1024" boot parameter without
> > success. How can I get my 128MB back ?
> > 
> 
> when you compile your 2.4.x kernel make sure you set the "4G of RAM"
> option, i.e. CONFIG_HIGHMEM4G. If you chose "up to 1G" then it means "up
> to 986M" (or something like that) -- the number in Help is just rounded up
     ~~~

not 986M but (unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)>>20 MB which is
around 876M or so.

Regards,
Tigran

