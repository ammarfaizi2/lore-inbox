Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUHaSSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUHaSSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUHaSSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:18:13 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:5066 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266291AbUHaSRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:17:51 -0400
Date: Tue, 31 Aug 2004 20:17:36 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <36793180.20040831201736@tnonline.net>
To: V13 <v13@priest.com>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
In-Reply-To: <200408312055.56335.v13@priest.com>
References: <41323AD8.7040103@namesys.com> <200408312055.56335.v13@priest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Sunday 29 August 2004 23:21, Hans Reiser wrote:
>> The Idea
>>
>> You should be able to access metadata about a file the same way you
>> access the file's data, but with a name based on the filename followed
>> by a name to select the metadata of interest.
>>
>> Examples:
>>
>> cat song_of_silence/metas/owner
>> cat song_of_silence/metas/permissions
>> cat 10 > song_of_silence/metas/mixer_defaults/volume
>> cat song_of_silence/metas/license

> Maybe I'm crazy but:

>  You're talking about a major change in the way filesystems work if this is
> going to be used by other FSs too. If  I understand this correctly it is a
> completely new thing and trying to do it by patching existing well-known
> 'primitives' may be wrong. 

>   AFAIK and AFAICS the metadata are not files or directories. You can look at
> them as files/dirs but they are not, just like a tar is not a directory. I
> believe that the correct thing to do (tm) is to add a new 'concept' named
> 'metadata' (which already exists). This way you'll have files, directories
> and metadata (or whatever you call them). So, each directory can have
> metadatas and files and each file can have metadatas. Then you have to
> provide some new methods of accessing them and not to use chdir() etc. (lets
> say chdir_meta() to enter the meta dir which will work for files too). After
> entering the 'metadir' you'll be able to use existing methods etc to access
> its 'files'.

>   This approach doesn't mess with existing things and can be extended for
> other filesystems too.

> (Just a thought)

  It  is a good thought. However I think they are trying to figure out
  a  way  to have the metadata and streams to be accesible with legacy
  applications.

  The  file-as-directory  concept is one way, which still seem to have
  issues.

  How  are  things  done on Windows platforms when there are files and
  directories  with the same name? In Unix that is imposible. How does
  it  work  for  environments  like  Cygwin  etc? What happen to tools
  that run in them?

> <<V13>>

