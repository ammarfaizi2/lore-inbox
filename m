Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310238AbSCBBXx>; Fri, 1 Mar 2002 20:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310236AbSCBBXn>; Fri, 1 Mar 2002 20:23:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35154 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310235AbSCBBXg>; Fri, 1 Mar 2002 20:23:36 -0500
Date: Sat, 2 Mar 2002 02:23:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: vm-28 for 2.4.19pre1
Message-ID: <20020302022301.B4431@inspiron.random>
In-Reply-To: <20020228174607.X1705@inspiron.school.suse.de> <200202281907.g1SJ7Ul16828@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202281907.g1SJ7Ul16828@ns.caldera.de>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 08:07:30PM +0100, Christoph Hellwig wrote:
>  - couldn't you make inc_nr_active_pages/dec_nr_active_pages/
> 	inc_nr_inactive_pages/dec_nr_inactive_pages inlines?
>    The current macro abuse isn't nice.

I just wanted to be sure to get the very best compilation (but yes, gcc
should be good enough anyways, so I'm fine to make it an inline instead
of a macro).

>  - in mm/memory.c (the 1141 chunk) you introduced a race.

I don't think so, that's a safe and worthwhile optimization (allows
minor swapins while swapcache is under swapout, that's perfectly safe
and it helps a lot).  There's no race there.

Andrea
