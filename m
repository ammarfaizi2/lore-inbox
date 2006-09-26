Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWIZUt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWIZUt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWIZUt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:49:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964799AbWIZUtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:49:25 -0400
Date: Tue, 26 Sep 2006 13:49:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-Id: <20060926134901.18fad0db.akpm@osdl.org>
In-Reply-To: <200609262213.26274.rjw@sisk.pl>
References: <200609231158.00147.rjw@sisk.pl>
	<200609231210.54692.rjw@sisk.pl>
	<20060926123907.4801a022.akpm@osdl.org>
	<200609262213.26274.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 22:13:25 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday, 26 September 2006 21:39, Andrew Morton wrote:
> > On Sat, 23 Sep 2006 12:10:54 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > In order to use a swap file with swsusp we need to know the offset at which
> > > its swap header is located.  However, the swap header is always located in the
> > > first page block of the swap file and it's quite easy to make sys_swapon() print
> > > the offset of the swap file's (or swap partition's) first page block.
> > 
> > Why is this needed?  The swapfile's pathname is present in /proc/swaps, so
> > an application can read that, do the FIBMAP and rewrite grub.conf without
> > needing to parse dmesg?
> 
> Well, this is not needed, but it's useful if you have no such application and
> want to set up things manually. ;-)

ick.  We need such an application (probably doable in a python script?). 
Methinks that telling people to go poking in dmesg will simply delay the
development and propagation of that application..
