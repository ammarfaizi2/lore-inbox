Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUFFIkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUFFIkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUFFIkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:40:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:20209 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263088AbUFFIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:38:34 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about cache and swap
Date: Sun, 6 Jun 2004 10:38:25 +0200
User-Agent: KMail/1.6.2
Cc: John Bradford <john@grabjohn.com>, Rik van Riel <riel@redhat.com>,
       Lasse =?iso-8859-15?q?K=E4rkk=E4inen_/_Tronic?= <tronic2@sci.fi>
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com> <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061038.29470.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Rik van Riel <riel@redhat.com>:
> > I wonder if we should just bite the bullet and implement
> > LIRS, ARC or CART for Linux.  These replacement algorithms
> > should pretty much detect by themselves which pages are
> > being used again (within a reasonable time) and which pages
> > aren't.
> Is there really much performance to be gained from tuning the 'limited'
> cache space, or will it just hurt as many or more systems than it helps?

Thats a very good question. 
Most of the time the current algorithm works quite well.
On the other hand, I definitely know what people mean when they complain 
about cachingand all this stuff. By just copying a big file that I dont use 
afterwards or watching an video I have 2 wonderful scenarios.  The cache is 
filled with useless information and big parts of KDE are neither in memory 
nor in cache. Applications  could use madvice or other things to indicate 
that they dont need this file a second time, but they usually dont. 

I think it might be interesting to have some kind of benchmark, similiar to 
the interactive benchmark of Con that just triggers the workload so many 
people are complaining. If I find the time, I will give it a try in the 
next days.

cheers

Christian
