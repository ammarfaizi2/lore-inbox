Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265743AbRGCSUw>; Tue, 3 Jul 2001 14:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265744AbRGCSUm>; Tue, 3 Jul 2001 14:20:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19219 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265743AbRGCSUg>; Tue, 3 Jul 2001 14:20:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marco Colombo <marco@esi.it>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM Requirement Document - v0.0
Date: Tue, 3 Jul 2001 20:24:14 +0200
X-Mailer: KMail [version 1.2]
Cc: <mike_phillips@urscorp.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107030932510.4236-100000@Megathlon.ESI> <01070317045806.00338@starship>
In-Reply-To: <01070317045806.00338@starship>
MIME-Version: 1.0
Message-Id: <01070320241408.00338@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ammendment to my previous post...

> I see three page priority levels:
>
>   0 - accessed-never/aged to zero
>   1 - accessed-once/just loaded
>   2 - accessed-often
>
> with these transitions:
>
>   0 -> 1, if a page is accessed
>   1 -> 2, if a page is accessed a second time
>   1 -> 0, if a page gets old
>   2 -> 0, if a page gets old

Better:

   1 -> 0, if a page was not referenced before arriving at the old end
   1 -> 2, if it was

Meaning that multiple accesses to pages on the level 1 list are treated as a 
single access.  In addition, this reflects what we can do practically with 
the hardware referenced bit.

--
Daniel
