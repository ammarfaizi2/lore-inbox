Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUH1ARM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUH1ARM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUH1ARL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:17:11 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:5589 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S265701AbUH1AQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:16:53 -0400
Date: Sat, 28 Aug 2004 02:19:03 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1798850364.20040828021903@tnonline.net>
To: Jamie Lokier <jamie@shareable.org>
CC: Rik van Riel <riel@redhat.com>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040827154156.GA31757@mail.shareable.org>
References: <412EEB75.1030401@namesys.com>
 <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
 <1888171711.20040827171520@tnonline.net>
 <20040827154156.GA31757@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam wrote:
>> > The problem is more fundamental than that.  Some of the
>> > file streams proposed need to be backed up, while others
>> > are alternative presentations of the file, which should
>> > not be backed up.
>> 
>>   No, not really. This is a user decision and should be options in the
>>   backup  software.  I don't think it is up to the kernel, filesystem,
>>   or  the  OS  in  general to decide what information the user want to
>>   retain or not.

> It is helpful for the OS, or a naming convention, to indicate what
> _is information_ though.

> It makes no sense to backup two or more copies of the _same
> information_, and it makes even less sense to try to restore them as
> it'll either be slow, fail (you can't always write to alternative
> presentations), or cause unwanted side effects.

> Just like when you backup a dynamic web site.  You store the files
> which the server is using.  You don't use "wget" to store the
> generated pages, that's not a useful backup and you can't restore from it.

  I do not agree. Everything can be considered information, even if it
  is derived from an already existing file.

  If  the  user  wants  to  not  backup certain things then that is an
  option to tell the backup program.

>> > Currently I see no way to distinguish between the stuff
>> > that should be backed up and the stuff that shouldn't.
>> 
>> > That problem needs to be resolved before we can even start
>> > thinking about fixing archivers...
>> 
>>   The  archivers  should,  as  I  said,  allow  the user to choose. It
>>   shouldn't be automatic. Default, should IMO be to store everything.

> Don't try to store different views of the same thing.
> When you try to restore, you _won't_ necessarily get back what you stored.

  No, it would be restored as it were before with the meta information
  intact.

> Whereas if you follow the OS's advice, and skip virtual files, then
> backup and restore will recreate the filesystem, which is what you want.

> _That's_ storing everything.  It's what you want from a backup.

  It would be storing everything but the virtual files.


> -- Jamie

