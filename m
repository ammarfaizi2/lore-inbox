Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTK3WuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTK3WuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:50:25 -0500
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:2745 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261929AbTK3WuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:50:23 -0500
Date: Mon, 1 Dec 2003 09:54:40 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Apurva Mehta <apurva@gmx.net>, Andries Brouwer <aebr@win.tue.nl>,
       John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130225439.GA464@gnu.org>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129223103.GB505@gnu.org> <1070182676.5214.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070182676.5214.2.camel@laptop.fenrus.com>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 09:57:56AM +0100, Arjan van de Ven wrote:
> > Intel's EFI GPT partition table format seems quite acceptable.
> 
> EFI GPT has some severe downsides (like requiring the last sector on
> disk, which in linux may not be accessible if the total number of
> sectors is not a multiple of 2,

Yeah, this does suck.  That ioctl hack isn't pretty.

> and making dd of one disk to another impossible if the second one is
> bigger)

You just lose some of the fault tolerance, until you rerun a partition
tool (or even boot a kernel) that re-does the end of it, adjusting
for the new disk size.

The whole point of having an extra copy of the table is to be fault
tolerant, not to introduce another point of failure!

Cheers,
Andrew

