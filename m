Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUE3WUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUE3WUN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 18:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUE3WUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 18:20:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:42446 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264419AbUE3WUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 18:20:08 -0400
Date: Mon, 31 May 2004 00:20:01 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040530222001.GD4681@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5g8yf9ljb3.fsf@patl=users.sf.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 05:02:59PM -0400, Patrick J. LoPresti wrote:

> > Various BIOS calls exist that report on various versions of the
> > geometry.
> 
> "Various"?  I know of two, the legacy INT13 interface and the extended
> INT13 interface.  Are there others?

Five years ago I made an attempt to get at the "true" geometry,
collecting all possible information from disk and BIOS.
I forgot all details, but among the sources were:

CMOS. INT 13, AH = 8, 15, 48. Tables pointed at by INT 41, INT 46.
Sometimes one finds data past the pointer given by INT 41.
IBM and Phoenix extensions.

The details depend on the brand of BIOS, which version of Phoenix
extensions is supported, whether the support is bugfree, etc.

The result in 1999 was that it is impossible to get at geometries
in a reliable way. I could not even come up with reasonable heuristics
that worked on the majority of the machines I had at home.

> Today, right now, the kernel invokes both the legacy and the extended
> INT13 interfaces for all disks which are visible to the BIOS.  The EDD
> module makes all of these data available.

Yes, I am happy with that.

(Much better than the old situation where HDIO_GETGEO gave
answers for one disk that belonged to some other disk.
Of course, EDD is not always available.)


Andries
