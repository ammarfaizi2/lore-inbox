Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbSJDQzP>; Fri, 4 Oct 2002 12:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSJDQzP>; Fri, 4 Oct 2002 12:55:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61095 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262485AbSJDQzO>;
	Fri, 4 Oct 2002 12:55:14 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 1/4: evms.c
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF9683DE97.19D23CC6-ON85256C48.005CD740@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 4 Oct 2002 12:07:05 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 01:00:41 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 04 October 2002 09:56, Christoph Hellwig wrote:

> > +/**
> > + * find_next_volume - locates first or next logical volume
> > + * @lv:            current logical volume
> > + *
> > + * returns the next logical volume or NULL
> > + **/
>
> All user of this look like they better used list_for_each?
>
> > +
> > +/**
> > + * find_next_volume_safe - locates first or next logical volume (safe
> > for removes) + * @next_lv:      ptr to next logical volume
> > + *
> > + * returns the next logical volume or NULL
> > + **/
>
> Dito with list_for_each_safe

This was done to abstract the storage/lookup
method. Currently with only 256 minors per major
a simply kernel list is adequate, however once
the kernel goes to 20-bit minors a list will not
be sufficient.


