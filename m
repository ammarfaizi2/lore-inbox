Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286882AbRLWMfT>; Sun, 23 Dec 2001 07:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286884AbRLWMfJ>; Sun, 23 Dec 2001 07:35:09 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:4109 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286882AbRLWMey>;
	Sun, 23 Dec 2001 07:34:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRM 4.0 support for kernel 2.4.17 
In-Reply-To: Your message of "Sun, 23 Dec 2001 13:28:24 BST."
             <20011223132824.A23866@caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 23:34:38 +1100
Message-ID: <24082.1009110878@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 13:28:24 +0100, 
Christoph Hellwig <hch@caldera.de> wrote:
>On Sun, Dec 23, 2001 at 10:48:36AM +1100, Keith Owens wrote:
>> Only if the new version cleans up the horrible drm 4.0 Makefile.
>
>I am more than happy to do so.  In fact I already did in 2.4.0-test times
>and got flamed by the drm crew..

Don't see why.  drm 4.1 uses a sane makefile, apart from a few dead
references to $(lib) which do nothing.  The separate copy of drmlib in
each object was meant to allow migration to a new format, it obviously
failed in its task, drm 4.1 is not compatible.  From drm 4.0 Makefile

# The upside is that if the DRM support library ever becomes insufficient
# for new families of cards, a new library can be implemented for those new
# cards without impacting the drivers for the old cards.  This is significant,
# because testing architectural changes to old cards may be impossible, and
# may delay the implementation of a better architecture.  We've traded slight
# memory waste (in the dual-head case) for greatly improved long-term
# maintainability.

Nice definition of long term, it survived 0 new releases.  Kill it.

