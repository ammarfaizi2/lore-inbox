Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUIFPNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUIFPNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIFPNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:13:51 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:44775 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268104AbUIFPNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:13:39 -0400
Date: Mon, 6 Sep 2004 17:13:20 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <826067315.20040906171320@tnonline.net>
To: Christer Weinigel <christer@weinigel.se>
CC: Pavel Machek <pavel@suse.cz>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <m3wtz7h2l6.fsf@zoo.weinigel.se>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
 <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
 <1215700165.20040905135749@tnonline.net> <20040905115854.GH26560@thundrix.ch>
 <1819110960.20040905143012@tnonline.net>
 <20040906105018.GB28111@atrey.karlin.mff.cuni.cz>
 <6010544610.20040906143222@tnonline.net> <m3wtz7h2l6.fsf@zoo.weinigel.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam <spam@tnonline.net> writes:

>> >>   The problem with the userspace library is standardization. What
>> >>   would be needed is a userspace library that has a extensible plugin
>> >>   interface that is standardized. Otherwise we would need lots of
>> >>   different libraries, and I seriously doubt that 1) this will happen
>> >>   and 2) we get all Linux programs to be patched to use it.
>> 
>> > libvfs from midnight commander (and anything build on the top of it)
>> > already is very extensible.
>> 
>>   This wasn't my point. My point was about all applications using it.
>>   Most aren't.

> So why do you think that just because you put an interface into the
> everyone will automatically start using it and use it without any
> conflicts (i.e. is foo/icon a windows icon, a gif, png, or jpeg file,
> what size is it, 16x16, 48x48...).  

> When you add a new shared namespace, userspace must be taught about it
> anyways.  So start with a userspace library, convince people to use
> it, and when you know what people want, _then_ put it into the kernel
> to increase performance or security.

  Several aspects of this;

  1) Programs will need to actually be coded against this shared
  library which probably will be more advanced that just usning normal
  file access code.
  
  2) Then we redo it all again to fit in the kernel, as a kernel
  plugin or user-level plugin.

> Don't start with "wouldn't it be
> nice if" without any thought behind it, it will just mean that we get
> another useless and misdesigned interface in the kernel that we have
> to live with for years.

  I am not saying that there should not be any thought behind
  implementing something. But from many hear I just hear a big no,
  without any thought about it either.

  Named streams and meta files are just one example of a general
  access to extra data that belongs to files. It seem to me as a much
  simpler way for program to use those than to link in several various
  libraries to do the same thing. 

  Plugins were just another thing that could extend the functionality
  of these streams and meta data. Reiser4 has a plugin architecture,
  although not yet any run-time support for loading them. Is this so
  bad that we have to prevent it?

  No one has to use them. maybe at some point it would be possible to
  specify which classes of plugins that could be loaded by a user and
  his files.

  What are the complaints about. The technical challenge to make
  things like this secure, or the concept to have this functionality
  at all. I do not think that because something is hard to do, it
  should be dismissed.

  ~S

  
> Do you know how long it took to get rid of /dev/cua0 and the locking
> mess associated with it?  (Deity!  I just checked on my FC2 system,
> it's still there.  I thought it would be dead by now.)

>   /Christer


