Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSJARgC>; Tue, 1 Oct 2002 13:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSJARdl>; Tue, 1 Oct 2002 13:33:41 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:38300 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262170AbSJARdH>;
	Tue, 1 Oct 2002 13:33:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: qsbench, interesting results
Date: Tue, 1 Oct 2002 19:38:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0210011426050.653-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0210011426050.653-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wQyx-0005va-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 19:29, Rik van Riel wrote:
> > Gimp should thrash exactly as much as it needs to, to get its job
> > done.  No competition, remember?
> 
> No competition ?  I know _I_ don't have a machine dedicated to
> gimp and I like to be able to continue listening to mp3s while
> the gimp is chewing on a large image...

Streaming IO has a very small footprint, essentially just the readahead,
so this has more to do with IO scheduling than paging.  VM just has to
take care not to completely close down the readahead window or throw
away readahead before it gets used.  No theoretical problem here, just a
small matter of coding ;-)

--
Daniel
