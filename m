Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267830AbUHZIbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267830AbUHZIbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUHZIbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:31:48 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29943 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267818AbUHZIbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:31:33 -0400
Message-ID: <412D9FE6.9050307@namesys.com>
Date: Thu, 26 Aug 2004 01:31:34 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org>
In-Reply-To: <20040825152805.45a1ce64.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>I had not intended to respond to this because I have nothing positive to 
>>say, but Andrew said I needed to respond and suggested I should copy 
>>Linus.
>>    
>>
>
>Yes, but I didn't say "flame Christoph and ignore the issues" ;)
>  
>
Oh....;-)

>There are lots of little things to do with implementation, coding style,
>module exports, deadlocks, what code goes where, etc.  These are all normal
>daily kernel business and we should set them aside for now and concentrate
>on the bigger issues.
>  
>
Yes, you are right, but I am not sure Viro will go along with that..... ;-)

>And as I see it, there are two big issues:
>
>a) reiser4 extends the Linux API in ways which POSIX/Unix/etc do not
>   anticipate and 
>
>b) it does this within the context of just a single filesystem.
>
>I see three possible responses:
>
>a) accept the reiser4-only extensions as-is (possibly with post-review
>   modifications, of course) or
>
>b) accept the reiser4-only extensions with a view to turning them into
>   kernel-wide extensions at some time in the future, so all filesystems
>   will offer the extensions (as much as poss) or
>
>c) reject the extensions.
>
>
>My own order of preference is b) c) a). 
>
I don't object to b), though I think b) should wait for 2.7 and reiser4 
should not.

> The fact that one filesystem will
>offer features which other filesystems do not and cannot offer makes me
>queasy for some reason.
>  
>
Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem 
for Apple, and that means we need to put search engine and database 
functionality into the filesystem.  It takes 11 years of serious 
research to build a clean storage layer able to handle doing that.  
Reiser4 has done that, finally.  None of the other Linux filesystems 
have.  The next major release of ReiserFS is going to be bursting with 
semantic enhancements, because the prerequisites for them are in place 
now.  None of the other Linux filesystems have those prerequisites.  
They won't be able to keep up with the semantic enhancements.  This 
metafiles and file-directories stuff is actually fairly trivial stuff.

Look guys, in 1993 I anticipated the battle would be here, and I build 
the foundation for a defensive tower right at the spot MS and Apple are 
now maneuvering towards.  Help me get the next level on the tower before 
they get here.  It is one hell of a foundation, they won't be able to 
shake it, their trees are not as powerful.  Don't move reiser4 into vfs, 
use reiser4 as the vfs.  Don't write filesystems, write file plugins and 
disk format plugins and all the other kinds of plugins, and you won't be 
missing any expressive power that you really want....

Give Saveliev and I some credit.  10 years of hard work at an ivory 
tower nobody thought mattered.  Now the battle leaves the browser and 
swings our way.  Don't duplicate that infrastructure, use it. 

There is so much we could use help with if talented people like you 
chose to contribute.

>b) means that at some time in the future we need to hoist the reiser4
>extensions (at a conceptual level) (and probably with restrictions) up into
>the VFS.  This will involve much thought, argument and work.
>
>
>To get us started on this route it would really help me (and, probably,
>others) if you could describe what these API extensions are in a very
>simple way, without referring to incomprehehsible web pages,
>
what is not comprehensible....?

> and without
>using terms which non-reiser4 people don't understand.
>  
>
Well, I agree that there is value in defining things in more detail than 
we have.

>It would be best if each extension was addressed in a separate email
>thread.
>
>We also need to discuss what a reiser4 "module" is, what its capabilities
>are, and what licensing implications they have.
>
>Then, we can look at each one and say "yup, that makes sense - we want
>Linux to do that" and we can also think about how we would implement it at
>the VFS level.
>
>If we follow the above route I believe we can make progress in a technical
>direction and not get deadlocked on personal/political stuff.
>
>
>Now, an alternative to all the above is to just merge reiser4 as-is, after
>addressing all the lower-level coding issues.  And see what happens.  That
>may be a thing which Linus wishes to do.  I'm easy.
>
>
>  
>

