Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbTCMTYJ>; Thu, 13 Mar 2003 14:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbTCMTYJ>; Thu, 13 Mar 2003 14:24:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:7639 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262507AbTCMTYI>;
	Thu, 13 Mar 2003 14:24:08 -0500
Date: Thu, 13 Mar 2003 11:34:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030313113448.595c6119.akpm@digeo.com>
In-Reply-To: <1047572586.1281.1.camel@ixodes.goop.org>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 19:34:45.0554 (UTC) FILETIME=[9A298120:01C2E997]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> On Thu, 2003-03-13 at 03:26, Andrew Morton wrote:
> >   This means that when an executable is first mapped in, the kernel will
> >   slurp the whole thing off disk in one hit.  Some IO changes were made to
> >   speed this up.
> 
> Does this just pull in text and data, or will it pull any debug sections
> too?  That could fill memory with a lot of useless junk.
> 

Just text, I expect.  Unless glibc is mapping debug info with PROT_EXEC ;)

It's just a fun hack.  Should be done in glibc.

