Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbRLTGZN>; Thu, 20 Dec 2001 01:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286171AbRLTGZD>; Thu, 20 Dec 2001 01:25:03 -0500
Received: from ns01.netrox.net ([64.118.231.130]:36017 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S286179AbRLTGYz>;
	Thu, 20 Dec 2001 01:24:55 -0500
Subject: Re: [PATCH] New per-cpu patch v2.5.1
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16GwUZ-0004xr-00@wagner.rustcorp.com.au>
In-Reply-To: <E16GwUZ-0004xr-00@wagner.rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 01:24:45 -0500
Message-Id: <1008829509.1213.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 01:15, Rusty Russell wrote:
> After some discussion, this may be a more sane (untested) per-cpu area
> patch.  It dynamically allocated the sections (and discards the
> original), which would allow (future) NUMA people to make sure their
> CPU area is allocated near them.
> 
> Comments welcome,

Would the next step be to find the various per-CPU data in the kernel
and convert it to your new form?  I.e., is this a general purpose
interface for per-CPU data structures, or am I missing something?

If it is, this is a good idea.  Other Unices have this (IRIX comes to
mind).  One of the biggest advantages, IMO, is simply the readability --
data structures that are per-CPU have varying methods of creation and
referencing.  The implicit locking (i.e., none) can be unclear.

Bring everything together can be a good thing.

	Robert Love

