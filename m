Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310359AbSCGPis>; Thu, 7 Mar 2002 10:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310364AbSCGPia>; Thu, 7 Mar 2002 10:38:30 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:48564 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310359AbSCGPiR>;
	Thu, 7 Mar 2002 10:38:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 16:32:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <E16iz6l-0002St-00@the-village.bc.nu>
In-Reply-To: <E16iz6l-0002St-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16izss-000390-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 03:43 pm, Alan Cox wrote:
> > Since there is always at least one freeable page in the system (or we're oom) then
> > we just have to find it and we know we can forcibly unmap it.  We do need to know
> > the total of pinned pages, I should have said locked/dirty/pinned.
> 
> What if I did a 4 page allocation ?

Higher order allocation - imho we can fix that too, eventually, however it's a lot
more work.  First we have to have reliable physical defragmentation.

> And if we are OOM - we want to return NULL

What good does that do?

-- 
Daniel
