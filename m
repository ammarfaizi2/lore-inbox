Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUGCKfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUGCKfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 06:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUGCKfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 06:35:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:49380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263585AbUGCKfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 06:35:24 -0400
Date: Sat, 3 Jul 2004 03:34:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-mm5] perfctr low-level documentation
Message-Id: <20040703033413.239d58d8.akpm@osdl.org>
In-Reply-To: <200407031028.i63AS9W3018392@harpo.it.uu.se>
References: <200407031028.i63AS9W3018392@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> On Fri, 2 Jul 2004 15:44:14 -0700, Andrew Morton wrote:
> >Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >>
> >> I'm
> >> considering Christoph Hellwig's suggestion of moving
> >> the API back to /proc/<pid>/, but with multiple files
> >> and open/read/write/mmap instead of ioctl. I believe I
> >> can make that work, but it would take a couple of days
> >> to implement properly. Please indicate if you would like
> >> this change or not.
> >
> >What would be the advantages of such a change?
> 
> Eliminating the 6 or so new syscalls I was forced
> to add when nuking the old ioctl() API.

syscalls are cheap.

> There would be a /proc/<pid>/<tid>/perfctr/ directory
> with files representing the control data, counter
> state, general info, and auxiliary control ops.

Futzing around with /proc handlers and mmapping /proc files doesn't sound
very attractive.  Unless we have some solid reason for changing things
I'd be inclined to leave it as-is.  Do you agree?
