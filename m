Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270748AbRIFNsH>; Thu, 6 Sep 2001 09:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270814AbRIFNr5>; Thu, 6 Sep 2001 09:47:57 -0400
Received: from [209.10.41.242] ([209.10.41.242]:40064 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S270748AbRIFNrh>;
	Thu, 6 Sep 2001 09:47:37 -0400
Date: Thu, 6 Sep 2001 15:42:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, riel@conectiva.com.br, jaharkes@cs.cmu.edu,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-Id: <20010906154212.442bdf7b.skraw@ithnet.com>
In-Reply-To: <592148204.999786238@[10.132.112.53]>
In-Reply-To: <20010906151015.69d2afb2.skraw@ithnet.com>
	<592148204.999786238@[10.132.112.53]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001 14:23:58 +0100 Alex Bligh - linux-kernel
<linux-kernel@alex.org.uk> wrote:

> 
> 
> --On Thursday, September 06, 2001 3:10 PM +0200 Stephan von Krawczynski 
> <skraw@ithnet.com> wrote:
> 
> > Obviously aging did not work at all,
> > there was not a single hit on these (CD image) pages during 24 hours,
> > compared to lots on the nfs-data.
> 
> If there's no memory pressure, data stays in InactiveDirty, caches,
> etc., forever. What makes you think more memory would have helped
> the NFS performance? It's possible these all were served out of caches
> too.

Negative. Switching off export-option "no_subtree_check" (which basically leads
to more small allocs during nfs action) shows immediately mem failures and
truncated files on the server and stale nfs handles on the client. So the
system _is_ under pressure. This exactly made me start (my branch of) the
discussion.
Besides I would really like to know what useable _data_ is in these pages, as I
cannot see which application should hold it (the CD stuff was quit "long ago").
FS should have sync'ed several times, too. 

Stephan

