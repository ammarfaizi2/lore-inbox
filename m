Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289886AbSAWRHt>; Wed, 23 Jan 2002 12:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289919AbSAWRHj>; Wed, 23 Jan 2002 12:07:39 -0500
Received: from dsl-213-023-038-076.arcor-ip.net ([213.23.38.76]:65433 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289886AbSAWRHg>;
	Wed, 23 Jan 2002 12:07:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Duraid Madina" <duraid@fl.net.au>, <linux-kernel@vger.kernel.org>
Subject: Re: VM: Where do we stand?
Date: Wed, 23 Jan 2002 18:12:26 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000901c1a3f0$d2e44ba0$022a17ac@simplex>
In-Reply-To: <000901c1a3f0$d2e44ba0$022a17ac@simplex>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16TQwk-00020U-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2002 10:32 am, Duraid Madina wrote:
> >The paging queues ( determing the age of the page and whether to 
> >free or clean it) need to be written... the algorithms being used
> >are terrible.
> >
> > * For the nominal page scan, it is using a one-hand clock algorithm.  
> >   All I can say is:  Oh my god!  Are they nuts?  That was abandoned
> >   a decade ago.

We don't use a one-hand clock now, we use an lru list coupled with a virtual 
scan which sucks slightly less, but only slightly.

> > The priority mechanism they've implemented is nearly
> >   useless.

There's a new priority mechanism now ;-)

> > * To locate pages to swap out, it takes a pass through the task list. 
> >   Ostensibly it locates the task with the largest RSS to then try to
> >   swap pages out from rather then select pages that are not in use.
> >   From my read of the code, it also botches this badly.

It now tries to select pages that are not in use.

--
Daniel
