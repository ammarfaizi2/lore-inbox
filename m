Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263087AbSJHC7N>; Mon, 7 Oct 2002 22:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263138AbSJHC7N>; Mon, 7 Oct 2002 22:59:13 -0400
Received: from dsl-213-023-043-140.arcor-ip.net ([213.23.43.140]:2990 "EHLO
	starship") by vger.kernel.org with ESMTP id <S263087AbSJHC7M>;
	Mon, 7 Oct 2002 22:59:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Simon Kirby <sim@netnation.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Date: Tue, 8 Oct 2002 04:47:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <3DA1E250.1C5F7220@digeo.com> <20021008023654.GA29076@netnation.com>
In-Reply-To: <20021008023654.GA29076@netnation.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ykOl-0003zM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 04:36, Simon Kirby wrote:
> Being able to defragment online would be very useful.  I've seen some
> people talk about this every so often.  How far away is it?

The vfs consistency semantics are a little complex and fragile at the
moment, which is the only thing that makes it hard.  Think about how
many months of truncate bugs we had, then consider how the situation
looks when all the bits of filesystem are moving around while its being
accessed.  That's not to say it won't happen, but it's unlikely to ever
be solid until the vfs semantics mature a little more.

-- 
Daniel
