Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289305AbSAIJpL>; Wed, 9 Jan 2002 04:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288569AbSAIJow>; Wed, 9 Jan 2002 04:44:52 -0500
Received: from dsl-213-023-043-044.arcor-ip.net ([213.23.43.44]:54285 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289305AbSAIJot>;
	Wed, 9 Jan 2002 04:44:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 10:48:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16OEr0-0000DR-00@starship.berlin> <3C3C0CB1.16A7CC5B@zip.com.au>
In-Reply-To: <3C3C0CB1.16A7CC5B@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OFL1-0000Dd-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2002 10:26 am, Andrew Morton wrote:
> Daniel Phillips wrote:
> > By the way, did you check for latency in directory operations?
> 
> Yes.  They can be very bad for really large directories.  Scheduling
> on the found-in-cache case in bread() kills that one easily for most
> local filesystems.  There may still be a problem in ext2.

A indexed directory won't have that problem - I'll get to finishing off the 
htree patch pretty soon[1].  In any event, the analogous technique will work: 
a schedule point in ext2_bread.

[1] Wli's hash work is happening at a convenient time.

--
Daniel
