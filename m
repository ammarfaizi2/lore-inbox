Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUIBUQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUIBUQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUIBUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:09:54 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:24196 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268937AbUIBUGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:06:12 -0400
Date: Thu, 2 Sep 2004 22:06:03 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <16310213029.20040902220603@tnonline.net>
To: Steve Bergman <steve@rueb.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <1094154744.12730.64.camel@voyager.localdomain>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay>
 <1094154744.12730.64.camel@voyager.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Thu, 2004-09-02 at 11:22 -0700, Martin J. Bligh wrote:
>> > For 30 years nothing much has happened in Unix filesystem semantics
>> > because of sheer cowardice 
>> 
>> Or because it works fine, and isn't broken.

> OK.  I'm not a kernel hacker.  I'm not a crack C programmer.  Nor am I a
> designer of filesystems.  I'm just a guy that puts together and supports
> Linux systems for my customers.

> In following this thread, I may be missing huge chunks of concept.

> However, a few things are becoming clear to me:

> 1. The file as directory thing adds complexity that the administrator
> has to deal with.  Symlinks are useful, but it's still aggravating to
> tar off a directory structure, take it somewhere, and then realize that
> all you have is links to something not in the archive because you didn't
> get your tar switches just right.  Now we're talking about adding
> another set of "files which are not really files" to the semantics.
> More complexity.  I'll take simplicity over some ivory tower ideal of
> "unified name space" any day.

  Are you afraid to learn something new? ;) Just joking. But really,
  it doesn't have to be very difficult. The extra streams etc would
  just be saved as files. If tar is patched then it would be no
  problem and no extra stuff but perhaps a switch --save-metas.

> 2. The use of multiple streams within files by Linux apps would make
> Linux as cross-platform unfriendly as MS is trying to be.  Say these
> features start getting used and you copy an OO.org document from a Linux
> box to a BSD box.  It's broken.  Of course, OO.org wouldn't use the
> streams in the first place because it would destroy their cross platform
> portability.  So what's the point?  No one who cares about cross
> platform portability can use it.  Everyone who doesn't care about cross
> platform portability please raise your hand.

  Actually MacOS and Windows support multiple streams, only Linux
  doesn't. But of course there are BSD's etc too. I'd say to leave
  them behind.

  The file streams would make my day a lot easier. The idea to
  split up contents of OO.org files into streams is bad. But that
  doesn't make the file streams bad. I see many uses that would make
  my every day life easier.

  It isn't about cross plat form compatibility, but to add features
  that are useful and meta-data and file streams are.

  Also. No one forces you to use either meta-data or streams, just as
  no one forces you to use ACLs or other things.

> 3. MS does require attributes and multiple streams, which makes these
> features important (even essential) to Samba, and Samba alone.  Samba is
> important to Linux, so this can't be ignored. (Here I am implicitly
> assuming that Samba will need kernel support for this to do it right.)

  I do not think the Samba would really require the streams support
  but it would certainly make life easier for Samba. Not to mention
  that these files would also be natively viewed on the Linux host.

> So it seems to me that the only real consideration is giving Samba what
> it needs without making the semantics one bit more complex than
> absolutely necessary.  It might even be wise to discourage use of these
> ambiguous new objects by the casual application programmer.

> Then again, maybe I just have tunnel vision... 

  I would agree with tunnel vision. The kernel should provide the
  tools and options. Users and developers can then invent new things
  to use them. :)

  ~S

> -Steve Bergman

