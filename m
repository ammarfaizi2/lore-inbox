Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316729AbSEWOV4>; Thu, 23 May 2002 10:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316730AbSEWOVy>; Thu, 23 May 2002 10:21:54 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64263 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316729AbSEWOVu>; Thu, 23 May 2002 10:21:50 -0400
Date: Thu, 23 May 2002 10:16:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
In-Reply-To: <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020523101302.11249C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Linus Torvalds wrote:

> Making the _generic_ code jump through hoops because some stupid special 
> case that nobody else is interested in is bad. 

Thoughts in no particular order:
 - set large page size based on file size or mapped section size
 - set LPS based on a capability on the program
 - set LPS based on a flag of some nature on the file
 - set LPS based on the number of processes mapping the file

I mention these because it would be nice to get better behaviour from
programs which aren't optimized for Linux and may never be.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

