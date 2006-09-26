Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWIZULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWIZULU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWIZULU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:11:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38879 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932268AbWIZULT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:11:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 4/6] swsusp: Add resume_offset command line parameter
Date: Tue, 26 Sep 2006 22:10:14 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609231158.00147.rjw@sisk.pl> <200609231208.25670.rjw@sisk.pl> <20060926123859.34e9b913.akpm@osdl.org>
In-Reply-To: <20060926123859.34e9b913.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262210.14595.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 September 2006 21:38, Andrew Morton wrote:
> On Sat, 23 Sep 2006 12:08:25 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Add the kernel command line parameter "resume_offset=" allowing us to specify
> > the offset, in <PAGE_SIZE> units, from the beginning of the partition pointed
> > to by the "resume=" parameter at which the swap header is located.
> 
> Is this description correct?

Yes, it is.  Please have a look at setup_swap_extents(). :-)

> I think it's in 512-byte units?

Well, no.

> It certainly should be - a filesytem could start the swapfile at any
> sector_t.

If I understand the code correctly, it looks for the first page-aligned
continuous region that contains as many blocks as to hold at least one
page.

