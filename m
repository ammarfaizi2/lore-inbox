Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUHZIse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUHZIse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267901AbUHZIpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:45:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34437 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268028AbUHZImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:42:19 -0400
Message-ID: <412DA26C.5060604@namesys.com>
Date: Thu, 26 Aug 2004 01:42:20 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Allison <jra@samba.org>
CC: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825202022.GK10907@legion.cup.hp.com>
In-Reply-To: <20040825202022.GK10907@legion.cup.hp.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Allison wrote:

>On Wed, Aug 25, 2004 at 12:53:28PM -0700, Hans Reiser wrote:
>  
>
>>You ignored everything I said during the discussion of xattrs about how 
>>there is no need to have attributes when you can just have files and 
>>directories, and that xattrs reflected a complete ignorance of name 
>>space design principles.  When I said we should just add some nice 
>>optional features to files and directories so that they can do 
>>everything that attributes can do if they are used that way, you just 
>>didn't get it.  You instead went for the quick ugly hack called xattrs.  
>>You then got that ugly hack done first, because quick hacks are, well, 
>>quick.  I then went about doing it the right way for Reiser4, and got 
>>DARPA to fund doing it.  I was never silent about it.
>>    
>>
>
>I don't want to comment on any of the technical issues about VFS etc. as
>I would be completely out of my depth, however I do want to say 2 things. Firstly,
>this is a feature that Samba users have been needing for many years to maintain
>compatibility with NTFS and Windows clients. Microsoft no longer sell any servers
>or clients without support for multiple data streams per file, and their latest
>XP SP2 code *does* use this feature. Whatever the kernel issues I'm really glad
>that Hans and Namesys have created something we can use to match this
>functionality - soon we will need it in order to be able to exist in
>a Microsoft client-dominated world.
>  
>
I agree that your work is important without agreeing that MS client 
domination will last.;-)  It is indeed my desire to give you every 
single feature you need to emulate MS streams within files, but doing it 
using directories that are files.  I would like to support you in 
emulating windows faster than windows.

>My second point is the following. Hans - did you *really* have to reinvent
>the wheel w.r.t userspace API calls ? Did you look at this work (done in 2001
>for Solaris) ?
>  
>
I interviewed for the file system architect job at Sun in, I think, 
1999, and they offered me the job conditional on my giving up on my 
Linux work.  (After much trying and failing to convince them that it 
would be okay for me to work on Linux also, I declined the job, much to 
my fiscal loss and work satisfaction.)

They do not do a pure job of implementing attributes in the file 
namespace though.  There are far more distinctions between files and 
attributes than are necessary that are described in these man pages 
below, and those distinctions cause a loss of closure.  I can say more 
on that if asked.

>http://bama.ua.edu/cgi-bin/man-cgi?fsattr+5
>http://bama.ua.edu/cgi-bin/man-cgi?attropen+3C
>http://bama.ua.edu/cgi-bin/man-cgi?openat+2
>
>I'm complaining here as someone who will have to write portable code
>to try and work on all these "files with streams" systems.
>
>Jeremy.
>
>
>  
>

