Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSEaQ5N>; Fri, 31 May 2002 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSEaQ5M>; Fri, 31 May 2002 12:57:12 -0400
Received: from [62.70.58.70] ([62.70.58.70]:4742 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316437AbSEaQ5L> convert rfc822-to-8bit;
	Fri, 31 May 2002 12:57:11 -0400
Message-Id: <200205311656.g4VGut009607@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Fri, 31 May 2002 18:56:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200205241004.g4OA4Ul28364@mail.pronto.tv> <200205301029.g4UATuE03249@mail.pronto.tv> <3CF67D5F.3398C893@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect nuke-buffers is simply always the right thing to do.  It's
> what 2.5 is doing now (effectively).  We'll see...
>
> But in your case, you only have a couple of gigs of memory, iirc.
> You shouldn't be running into catastrophic buffer_head congestion.
> Something odd is happening.
>
> If you can provide a really detailed set of steps which can be
> used by others to reproduce this, that would really help.

What I do: start lots (10-50) downloads, each with a speed of 4,5Mbps from 
another client. The two are connected using gigEthernet. downloads are over 
HTTP, with Tux or other servers (have tried several). If the clients are 
reading at full speed (e.g. only a few clients, or reading directly from 
localhost), the problem doesn't occir. However, when reading at a fixed rate, 
it seems like the server is caching itself to death.


Detailed configuration:

- 4 IBM 40gig disks in RAID-0. chunk size 1MB
- 1 x athlon 1GHz
- 1GB RAM - no highmem (900 meg)
- kernel 2.4.19pre7 + patch from Andrew Morton to ditch buffers early 
        (thread: [BUG] 2.4 VM sucks. Again)
- gigEthernet between test client and server

Anyone got a clue?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
