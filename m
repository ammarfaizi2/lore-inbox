Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318599AbSHWHqm>; Fri, 23 Aug 2002 03:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSHWHqm>; Fri, 23 Aug 2002 03:46:42 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47624
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318599AbSHWHql>; Fri, 23 Aug 2002 03:46:41 -0400
Date: Fri, 23 Aug 2002 00:49:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <3D65E0DA.750FAA04@aitel.hist.no>
Message-ID: <Pine.LNX.4.10.10208230045530.14761-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Helge Hafting wrote:

> Andre Hedrick wrote:
> > 
> > Oh and it is only useful for borken things like LINBIOS and other
> > braindead systems like ARM that violate the 31 second rule of POST.
> > 
> 31s of POST is uselessly slow.  Perhaps it is needed when
> the drives _are_ spinning up, but not for the common
> case of rebooting to activate a new kernel
> (or reset button when the dev-kernel hung.)  The disk
> is spinning already in those cases, and there should 
> be no bootup delay.

Correct, and your case is different than from power on cold.
Regardless, you isse EXECUTE DIAGNOSITCS and there are device which wait
until the last minute to respond.

There are things called shadow registers.

Where the slave device answers for or as the master device in this special
case.  Now if you have a master (atapi) without shadow registers but slave
(atapi) with shadow registers, guess what sometimes the master negates
the slaves attempt to report.  So this command fails here even after a
warm boot.

Now what?


Andre Hedrick
LAD Storage Consulting Group

