Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263297AbSJCMkb>; Thu, 3 Oct 2002 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbSJCMkb>; Thu, 3 Oct 2002 08:40:31 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:31919 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263297AbSJCMkU>; Thu, 3 Oct 2002 08:40:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 07:13:11 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <02100216332002.18102@boiler> <20021002224343.GB16453@kroah.com>
In-Reply-To: <20021002224343.GB16453@kroah.com>
MIME-Version: 1.0
Message-Id: <02100307131100.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 17:43, Greg KH wrote:
> Some comments on the code:
> 	- you might want to post a patch with the whole evms portion of
> 	  the code, for those people without BitKeeper to see.
> 	- The #ifdef EVMS_DEBUG lines are still in AIXlvm_vge.c, I
> 	  thought you said you were going to fix this file up?
> 	- The OS2 and S390 files don't look like they have been fixed,
> 	  like you said you would before submission.

I have been working on these, and should have them done very soon. At the 
very least, I expect to get OS2 done today. I will let you know as soon as it 
is ready.

> 	- evms_ecr.h and evms_linear.h have a lot of unneeded typedefs.

For the time being, I have removed these files from the tree. As I mentioned 
the other day, they are a long way from providing any useful clustering 
functionality.

> 	- the md code duplication has not been addressed, as you said it
> 	  would be.

We will be addressing this. Unfortunately, I don't see this as being a 
simple, overnight fix. Finding a way to consolidate the common code may take 
some time.

> 	- the BK repository contains a _lot_ of past history and merges
> 	  that are probably unnecessary to have.  A few, small
> 	  changesets are nicer to look at :)

No offense meant, Greg, but that seems a bit contradictory. The way I see it, 
I can maintain our Bitkeeper tree in one of two ways.

1) Try to mirror the usage of our CVS tree. This means that each file or 
small group of files that gets checked into CVS also gets checked into 
Bitkeeper, and the comment logs can stay closely in sync. Doing this produces 
a _lot_ of _small_ changesets, but each one is fairly easy to read and 
understand. However, as you mentioned, it does produce a very long history.

2) Just do a periodic sync with the current CVS tree, maybe every three days 
or so. This will obviously produce far less history, but each changeset may 
be quite large, and thus harder to read and understand, especially since the 
comments will likely be something along the lines of "sync'ing with CVS".

> Why don't you propose a small evms patch that adds the core
> functionality, and worry about getting all of the plugins and other
> assorted stuff in later?  You will probably get more constructive
> comments, as wading through a patch 37956 lines long is a bit difficult.

This is fine with me. I've been maintaining our Bitkeeper tree because I've 
been told by numerous people that it is the easiest way to get new code 
accepted into the kernel. If it turns out that this isn't actually the best 
approach, I'll be more than happy to just send patches. Dual-maintaining CVS 
and Bitkeeper trees is certainly no small task.

So, I will send in a few patches that introduce just the core code so 
everyone can get a good look. There will be four files coming: evms.c, 
evms.h, evms_ioctl.h, and evms_biosplit.h.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
