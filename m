Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUH0UrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUH0UrU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUH0UpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:45:04 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:22996 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S267405AbUH0Ul6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:41:58 -0400
Date: Fri, 27 Aug 2004 22:44:04 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1732169380.20040827224404@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>, <torvalds@osdl.org>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200408261812.i7QICW8r002679@localhost.localdomain>
References: Message from Hans Reiser <reiser@namesys.com>    of "Thu, 26 Aug
 2004 01:31:34 MST." <412D9FE6.9050307@namesys.com>
 <200408261812.i7QICW8r002679@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hans Reiser <reiser@namesys.com> said:
>> Andrew Morton wrote:

> [...]

>> > The fact that one filesystem will offer features which other
>> > filesystems do not and cannot offer makes me queasy for some reason.

> Not me. As long as it is clearly experimental stuff that can be removed at
> the head hacker's whim, that is. 2.7 material.

>> Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem
>> for Apple,

> Says who?

  At  least  I  as  a user see the benefits largely. The workstation /
  desktop  user has much more need for such features, than perhaps the
  normal Linux sysadmin.

>>            and that means we need to put search engine and database
>> functionality into the filesystem.

> Please don't. Unix works and is extremely popular because it _doesn't_ try
> to be smart (policy vs mechanism distinction, simple abstractions that can
> be combined endlessly). If you add this to the filesystems, you either redo
> _all_ userland to understand _one_ particular way of doing "smart things"
> (which will turn out to be almost exactly the dumbest possible for some
> uses, and then you are stuck), or get lots of shards from broken apps (and
> users, and sysadmins).

  Indeed.  But  you forget one thing. Combining lots of small userland
  tools can actually make things more complex - at least for the user.

  That said, I do not see that anyone has suggested to remove this way
  of  working with applications.

  Are the new and old features mutually exclusive?

>>                                     It takes 11 years of serious 
>> research to build a clean storage layer able to handle doing that.

> Great! Build an experimental OS showing how to use it, and through that see
> if the ideas hold any water _in real, day-to-day, down-to-earth, practice_.

  There  are  many  uses already. It could be encryption, compression,
  meta-data,  file streams, sorting, searching and a multitude of uses
  and ideas that haven't been discovered yet.

>> Reiser4 has done that, finally.  None of the other Linux filesystems
>> have.

> How come nobody before you in the almost 30 years of Unix has ever seen the
> need for this indispensable feature?

  I,  as  a  user, have for a long time. Do not drag everyone over the
  same  edge.  Users  have  different  needs.  We  should try to be as
  forthcoming as possible to provide the tools and options for them.

>>        The next major release of ReiserFS is going to be bursting with
>> semantic enhancements, because the prerequisites for them are in place
>> now.  None of the other Linux filesystems have those prerequisites.

> To me that would mean that ReiserFS has no place in Linux.

  Why  do  you say this? I thought Linux embraced advancements and new
  technologies.

>> They won't be able to keep up with the semantic enhancements.  This
>> metafiles and file-directories stuff is actually fairly trivial stuff.

> Maybe. But the question of it being of any use aren't trivially answered
> "yes". My gut feeling is that the answer is a resounding "no", but that's
> just me. Direcories are directories, if you want to ship directory-like
> stuff around, use directories (or tarfiles, or whatever). Just look what
> happened to the much, much easier stuff of splitting SUID/SGID into
> capabilities: Nothing at all whatsoever, because they have no decent place
> to stay in the hallowed Unix APIs. Sure, Linux is now large enough to be
> able to _define_ APIs to follow, but even so it isn't at all easy to do so.

  Exactly.  The  problem  I see in this discussion is the lack of just
  this - APIs. Because the lack of good APIs we cannot make any larger
  changes or bring new features because old applications will break.

  I think that Linux should make new API that will completely separate
  applications  from the storage media. This way we will not as easily
  break  applications  when new features are developed. This should be
  the main priority.

  Perhaps  over a transition period the old ways will be allowed while
  applications  are  ported  to  the new APIs. The change is certainly
  going  to be needed at one point or Linux won't be able to evolve as
  quickly as its users are demanding it.

  Application  breakage  has  happened  before between virtually every
  kernel change. It isn't new. Just take devfs and sysfs.


>> Look guys, in 1993 I anticipated the battle would be here, and I build
>> the foundation for a defensive tower right at the spot MS and Apple are
>> now maneuvering towards.

> Why place a protective tower around the pit into which they are trying
> desperately to throw themselves? ;-)

  It  is easy to say this. But the fact is that users can actually use
  these new features for good things.

>>                           Help me get the next level on the tower before
>> they get here.  It is one hell of a foundation, they won't be able to
>> shake it, their trees are not as powerful.  Don't move reiser4 into vfs,
>> use reiser4 as the vfs.  Don't write filesystems, write file plugins and
>> disk format plugins and all the other kinds of plugins, and you won't be
>> missing any expressive power that you really want....

> Better write libraries handling whatever weird format you have in mind for
> each use. Even applications. I don't expect to be able to use emacs to edit
> a JPEG or PostgreSQL database. Neither do I expect gimp to be able to edit
> a poem. The current trend (which I heartily agree with) is to take stuff
> _out_ of the kernel (for flexibility, access, development ease, even
> performance).

  If  I  want  to  be able to quickly find files by a certain author I
  could   search  the  meta-data fields (if they are used) with normal
  tools such as grep.

  Compression or encryption is another example.

  Would  you  rather  patch  every  application  there is for Linux to
  enable support for reading these files and directories?

  



