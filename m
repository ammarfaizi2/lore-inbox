Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbSJGRog>; Mon, 7 Oct 2002 13:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbSJGRof>; Mon, 7 Oct 2002 13:44:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13291 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262264AbSJGRof>;
	Mon, 7 Oct 2002 13:44:35 -0400
Date: Mon, 7 Oct 2002 13:50:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@infradead.org>
cc: Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 3/4: evms_ioctl.h
In-Reply-To: <20021007183415.A22316@infradead.org>
Message-ID: <Pine.GSO.4.21.0210071340580.29030-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Oct 2002, Christoph Hellwig wrote:

> I don't think that basing kernel internal interfaces on ioctl is
> a smart idea.  Just add another function pionter to your operations
> vector for every operation you want supported on volumes.

s/every/& generic/.  Other than that, seconded.  BTW, one of the pending
changes is taking the last more or less generic ioctl (HDIO_GETGEO) into
a separate method...

->ioctl() is for driver-specific crud; stuff that won't be used by
any generic application.  "Make a cuckoo jump out of drive and sing
'1000 bottles of beer'" is a valid ioctl.  "Get drive size" isn't.

