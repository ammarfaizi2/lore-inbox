Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUH2QRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUH2QRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUH2QRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:17:19 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:2696 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268065AbUH2QRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:17:08 -0400
Date: Sun, 29 Aug 2004 18:18:28 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <584579467.20040829181828@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200408272358.i7RNweGh002703@localhost.localdomain>
References: Message from Spam <spam@tnonline.net>    of "Thu, 26 Aug 2004
 13:15:47 +0200." <1453776111.20040826131547@tnonline.net>
 <200408272358.i7RNweGh002703@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam <spam@tnonline.net> said:
>> Andrew Morton <akpm@osdl.org> said:

> [...]

>> > For example, some image file formats already support embedded metadata, do
>> > they not?

>>   Yes, JPEG, TIFF and PNG files for example. But, if you modify any of
>>   these  with  an application that doesn't support the extensions then
>>   you will loose them.

> As you will each time you muck around with your files-are-directories.
> Nothing new there.

>>   Also,  you  are thinking _very_ narrowly now. There are thousands of
>>   file  formats.  Implementing  the  support  for  meta-data/ streams/
>>   attributes  in  the  kernel  will  make  it  possible  to  use  this
>>   generically for all files.

> So the _kernel_ has to know about thousands of formats, just in case it
> some blue day it comes across a strange file? Better leave that to the
> applications.

  No,  not  at all. The only think the kernel would need to support is
  the actual meta files and streams - not the contents of the streams.
  That is up to the applications to know and use.

  The  idea  with  plugins  to reiser4 would allow someone to create a
  plugin that would export the thumbnails from TIFF and JPEG images as
  separate streams.

> You will _not_ be able to define a single format for extra data about the
> file, there will be differing extra data for different users (do you
> suggest a root-only file with special writable pouches for "graphical icon
> for the file" for each user on the system?!), so the idea in itself is
> doomed from the start.

  We  do  not need to define a single format. You are locking yourself
  to  the contents of streams and meta files.

  If  someone  likes  the  idea of a plugin that would allow for icons
  then  that  may  be  it. It would be up to application developers to
  know  about  this and use it. Perhaps they could agree on a standard
  even.
>>   I  use  this  in  Windows  quite much.

> Then use it and be happy. No need to screw up Linux for that.

  This  wouldn't  screw anything up besides allowing for extending the
  functionality.  There  is noone that forces you to enable and instll
  plugins,  use  extra attributes or meta info. All of this always was
  optional (as I see it).

>>                                          I put information description
>>   fields  for  lots  of  different  files. These descriptions are then
>>   searchable etc. I could use the command prompt to copy the files and
>>   the descriptions would still be there.

> The descriptions might make sense to _you_, _now_. No guarantee they make
> any sense (or are in the least useful) for other users on your system, and
> I might want them in arabic or some such. The descriptions might make no
> sense to you in a couple of years.

  So? The same may be for your own word documents etc. It doesn't mean
  I do not find it useful now, or that anyone else might not. Shall we
  not  include  features  because "someone" on the same system may not
  use it? Seems very backward to me.

  If   I   include   a filestream, description.xml, then that wouldn't
  affect  anyone. I would know how to read the file, and that would be
  enough.

>>   Secondly, do you expect file managers like Nautilus and Konqueror to
>>   support  every piece of file format on the planet so they could read
>>   information directly from the documents?

> That's their (self-selected) job, yes.

  Yes  and  no.  I  used  them  as example but there are lots of other
  programs  that  can access files. Midnight commander, cp, tar, email
  programs and lots of others.

  besides, I think it would be easier for them to 1) write plugins and
  2)  just  use normal file access method to provide the extra data to
  the users.

