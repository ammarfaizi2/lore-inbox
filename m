Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSKKU3I>; Mon, 11 Nov 2002 15:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSKKU3I>; Mon, 11 Nov 2002 15:29:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6898 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261305AbSKKU3I>; Mon, 11 Nov 2002 15:29:08 -0500
Date: Mon, 11 Nov 2002 15:35:39 -0500
From: Doug Ledford <dledford@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, geert@linux-m68k.org,
       hch@infradead.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
Message-ID: <20021111203537.GC11636@redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, geert@linux-m68k.org,
	hch@infradead.org, Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036939080.1005.10.camel@irongate.swansea.linux.org.uk> <Pine.GSO.4.21.0211111029030.20946-100000@vervain.sonytel.be> <20021111.014328.87369858.davem@redhat.com> <1037019925.2887.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037019925.2887.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 01:05:25PM +0000, Alan Cox wrote:
> Lots of drivers do

Yes, this part sucks.  There needs to be an easy library function that
takes a scsi command pointer, sets up a wait queue, adds the wait queue
struct pointer to the scsi command, sleeps with a timeout, wakes up when
command completes via scsi_done() or timeout fires, returns value based
upon how wake up happened.  Right now we don't have that, we only have a
little helper function, scsi_sleep(), for sleeping for a fixed length of 
time.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
