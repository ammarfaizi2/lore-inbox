Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTB1AAI>; Thu, 27 Feb 2003 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTB1AAI>; Thu, 27 Feb 2003 19:00:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:65417 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267277AbTB1AAH>;
	Thu, 27 Feb 2003 19:00:07 -0500
Date: Thu, 27 Feb 2003 16:06:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Message-Id: <20030227160656.40ebeb93.akpm@digeo.com>
In-Reply-To: <200302281056.45501.kernel@kolivas.org>
References: <20030227025900.1205425a.akpm@digeo.com>
	<20030227134403.776bf2e3.akpm@digeo.com>
	<118810000.1046383273@baldur.austin.ibm.com>
	<200302281056.45501.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 00:10:20.0456 (UTC) FILETIME=[C7F2D280:01C2DEBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Fri, 28 Feb 2003 09:01 am, Dave McCracken wrote:
> > --On Thursday, February 27, 2003 13:44:03 -0800 Andrew Morton
> >
> > <akpm@digeo.com> wrote:
> > >> ...
> > >> Mapped:       4294923652 kB
> > >
> > > Well that's gotta hurt.  This metric is used in making writeback
> > > decisions.  Probably the objrmap patch.
> >
> > Oops.  You're right.  Here's a patch to fix it.
> 
> Thanks. 
> 
> This looks better after a run:
> 
> MemTotal:       256156 kB
> ...
> Mapped:        4546752 kB

No, it is still wrong.  Mapped cannot exceed MemTotal.


