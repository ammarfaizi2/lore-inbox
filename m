Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVH1Trz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVH1Trz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVH1Trz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 15:47:55 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:30401 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750770AbVH1Trz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 15:47:55 -0400
X-ORBL: [69.107.75.50]
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [linux-usb-devel] Re: USB EHCI Problem with Low Speed
Date: Sun, 28 Aug 2005 12:47:42 -0700
User-Agent: KMail/1.7.1
Cc: dio@qwasartech.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508281247.42776.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112439094723976&w=2

Yes please ... these issues do seem to be intermittent and hardware-specific,
so we'd like to know if relaxed enumeration timings work better for the folk
who have these problems.


> Yes, Dominik, please do. The TT was a poor guess, because IIRC 2.6.8
> did not have the support for TT, so it could not get it wrong.

Actually every EHCI version from kernel.org has always supported TTs;
I didn't submit it until full and low speed devices would enumerate,
an I could use USB keyboards and mice.  The reason it's a poor guess
is that TT support has nothing to do with this level of problem.  ;)

What's changed is how smart the _periodic scheduling_ support is.
The original algorithm took some major simplifying shortcuts, which
reduced functionality.  The latest code doesn't have very many of
those shortcuts.  It's accordingly a LOT more complicated.  Some
of the newer features need work yet (e.g. scheduling ISO OUT).

- Dave

