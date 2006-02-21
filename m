Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWBUUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWBUUkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbWBUUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:40:33 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:25992 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932703AbWBUUkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:40:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 21 Feb 2006 21:40:56 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602211257.29161.ncunningham@cyclades.com> <200602202319.15018.dtor_core@ameritech.net>
In-Reply-To: <200602202319.15018.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212140.57566.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 05:19, Dmitry Torokhov wrote:
> On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > For the record, my thinking went: swsusp uses n (12?) bytes of meta data for 
> > every page you save, where as using bitmaps makes that much closer to a 
> > constant value (a small variable amount for recording where the image will be 
> > stored in extents). 12 bytes per page is 3MB/1GB. If swsusp was to add 
> > support for multiple swap partitions or writing to files, those requirements 
> > might be closer to 5MB/GB. 
> 
> 5MB/GB amounts to 0.5% overhead, I don't think you should be concerned here.
> Much more important IMHO is that IIRC swsusp requires to be able to free 1/2
> of the physical memory whuch is hard on low memory boxes.

I see another point in using bitmaps: we could avoid modifying page flags
and use bitmaps to store all of the temporary information.  I thought about
it for some time and I think it's doable.

Greetings,
Rafael
