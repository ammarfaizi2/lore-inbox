Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUHYTzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUHYTzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268503AbUHYTzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:55:36 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24006 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268443AbUHYTxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:53:32 -0400
Message-ID: <412CEE38.1080707@namesys.com>
Date: Wed, 25 Aug 2004 12:53:28 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>
In-Reply-To: <20040824202521.GA26705@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had not intended to respond to this because I have nothing positive to 
say, but Andrew said I needed to respond and suggested I should copy 
Linus. Sigh.

Dear Christoph,

Let me see if I can summarize what you and your contingent are saying, 
and if I misconstrue anything, let me know.;-)

You ignored everything I said during the discussion of xattrs about how 
there is no need to have attributes when you can just have files and 
directories, and that xattrs reflected a complete ignorance of name 
space design principles.  When I said we should just add some nice 
optional features to files and directories so that they can do 
everything that attributes can do if they are used that way, you just 
didn't get it.  You instead went for the quick ugly hack called xattrs.  
You then got that ugly hack done first, because quick hacks are, well, 
quick.  I then went about doing it the right way for Reiser4, and got 
DARPA to fund doing it.  I was never silent about it.

Making files into directories caused only two applications out of the 
entire OS to notice the change, and that was because of a bug in what 
error code we returned that we are going to fix.  You think that was a 
disaster; I think it was a triumph.

Now a cleanly architected filesystem with no attributes and just files 
and directories that can do everything attributes are used for exists.  
You don't want it to have the competitive advantage.  Instead, you want 
it to have its clean design excised until you have something that 
duplicates it ready to go, and only then should it be allowed that users 
will use the features of your competitor's filesystem which you 
disdained implementing for so long.

Since you never studied or understood namespace design principles (or 
you would not have created and supported xattrs), you want to rename it 
to be called VFS, rewrite what we have done, and take over as the 
maintainer, mangling its design in a committee clusterfuck as you go. 

We have just implemented very trivial semantic enhancements of the FS 
namespace, nothing like as ambitious as www.namesys.com/whitepaper.html 
or WinFS, and you are already pissing your pants.

Is that a fair summary?

Eat my dust. 

Hans

PS

I should of course qualify what I have said.  The use of files and 
directories in place of attributes is not a finished work.  It has bugs, 
sys_reiser4() does not yet work, and there are little features still 
missing like having files readdir ignores.

Still, except for the bugs, what we have is usable, and there are a lot 
of happy reiser4 users right now even with the bugs. It will need a 
little bit more time, and then all the pieces will be in place.

PPS

If you implement your filesystems as reiser4 plugins, and rename 
reiser4's plugin code to be called "vfs", your filesystems will go 
faster.  Not as fast as reiser4 though, because it has a better layout 
and that affects performance a lot, but faster is faster....  See 
www.namesys.com/benchmarks.html for details.

PPPS

 Since we have such a performance lead, Namesys is about to change its 
focus from the storage layer to semantics, look at 
www.namesys.com/whitepaper.html for details.  Semantic enhancements are 
the important stuff, and finally Namesys is where we have all the 
storage layer prerequisites done right, and the real work can begin.  
The gap between us is about to widen further.



Christoph Hellwig wrote:

>After looking trough the code and mailinglists I'm quite unhappy with
>a bunch of user-visible changes that Hans sneaked in and make reiser4
>incompatible with other filesystems 
>
if we leave you in the dust, run faster.... not my problem....


>Given these problems I request that these interfaces are removed from
>reiser4 for the kernel merge, and if added later at the proper VFS level
>after discussion on linux-kernel and linux-fsdevel, like we did for
>xattrs.
>
>
>  
>
If you can't help fight WinFS, then get out of the way.  Namesys is on 
the march.  Read www.namesys.com/whitepaper.html.

Or, be smart, recognize that reiser4 is faster and more flexible than 
your storage layers because we are older and wiser and worked harder at 
it, join the team, and start contributing plugins that tap into the 
higher performance it offers.

Microsoft tried to build a storage layer that could handle small objects 
without losing performance, failed, and gave up at considerable cost to 
their architecture and pocketbook.

We just broke a hole in the enemy line.  You could come swarming through 
it with us, but it sounds like you prefer complaining to HQ that we are 
getting too far in front of you.

