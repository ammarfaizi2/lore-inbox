Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263229AbTCNC4r>; Thu, 13 Mar 2003 21:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263230AbTCNC4r>; Thu, 13 Mar 2003 21:56:47 -0500
Received: from [216.234.192.169] ([216.234.192.169]:34311 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S263229AbTCNC4r>; Thu, 13 Mar 2003 21:56:47 -0500
Subject: Re: 2.5.64-mm6
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030313113448.595c6119.akpm@digeo.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org> 
	<20030313113448.595c6119.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 13 Mar 2003 20:04:48 -0700
Message-Id: <1047611104.14782.5410.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 12:34, Andrew Morton wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> >
> > On Thu, 2003-03-13 at 03:26, Andrew Morton wrote:
> > >   This means that when an executable is first mapped in, the kernel will
> > >   slurp the whole thing off disk in one hit.  Some IO changes were made to
> > >   speed this up.
> > 
> > Does this just pull in text and data, or will it pull any debug sections
> > too?  That could fill memory with a lot of useless junk.
> > 
> 
> Just text, I expect.  Unless glibc is mapping debug info with PROT_EXEC ;)
> 
> It's just a fun hack.  Should be done in glibc.

Well, fun hack or glibc to-do list candidate, I hope it doesn't get
forgotten.  I am happy to confirm that it did speed up the initial
launch time of Open Office from 20 seconds (2.5-bk) to 11 seconds (-mm6)
and Mozilla from 10 seconds (2.5-bk) to 6 seconds (-mm6).

I did run 2.5.64-mm6 with mem=64M under stress for several hours and it
took a beating and kept on ticking, although quite slowly.

Steven


