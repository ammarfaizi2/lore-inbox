Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSGJQpG>; Wed, 10 Jul 2002 12:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSGJQpF>; Wed, 10 Jul 2002 12:45:05 -0400
Received: from holomorphy.com ([66.224.33.161]:7568 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317540AbSGJQpF>;
	Wed, 10 Jul 2002 12:45:05 -0400
Date: Wed, 10 Jul 2002 09:46:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Marco Colombo <marco@esi.it>, Larry McVoy <lm@bitmover.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020710164645.GR25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>, Marco Colombo <marco@esi.it>,
	Larry McVoy <lm@bitmover.com>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020708222127.G11300@work.bitmover.com> <Pine.LNX.4.44.0207101144010.728-100000@Megathlon.ESI> <20020710154003.Z27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020710154003.Z27706@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 12:03:08PM +0200, Marco Colombo wrote:
>> Larry, there's something I've always wanted to ask you about your
>> idea of the "locking cliff": when you're counting the number of locks,
>> are you looking at the running image of an OS or at the source? 

On Wed, Jul 10, 2002 at 03:40:03PM +0100, Matthew Wilcox wrote:
> Larry normally talks about the number of conceptual locks.  So in order
> to manipulate a `struct file', it really doesn't matter whether you have
> to grab the BKL, the files_struct lock or the filp->lock.  There's a big
> difference if you have to grab the filp->pos_lock, the filp->ra_lock and
> the filp->iobuf_lock.  You'd have to know what order to grab them in,
> for a start.

This is called "lock depth" and is not related to the total number of
locks declared in the source. AFAIK no one wants to increase lock depth.


Cheers,
Bill
