Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUH1LTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUH1LTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUH1LTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:19:30 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:3202 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266334AbUH1LSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:18:48 -0400
Date: Sat, 28 Aug 2004 13:21:02 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1018894074.20040828132102@tnonline.net>
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <4130562B.5020709@namesys.com>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
 <4130562B.5020709@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I  am  thinking  that  is  there  was a proper API for accessing the
  filesystem  then this problem wouldn't arise because things could be
  done  behind  the curtains inside the API, instead of having all the
  tools to be rewritten to know.

  Think of FAT32, for example, the new filenames will be retained even
  if  you use old tools on them. It is only if you mount it as a FAT16
  volume they will be lost.

  Even  if  this  is fixed for Reiser4 now. Next time someone wants to
  make  changes like this we have the exact same problem yet again.
  

> Just have a special name instead of a special boundary, or, better, have
> a filename/pseudos/backup method that outputs everything needed to 
> backup the object "filename".

> Hans

> Linus Torvalds wrote:

>>On Fri, 27 Aug 2004, Rik van Riel wrote:
>>  
>>
>>>Thing is, there is no way to distinguish between what are
>>>virtual files and what are actual streams hidden inside a
>>>file.  You don't know what should and shouldn't be backed
>>>up...
>>>    
>>>
>>
>>I think that lack of distinguishing poiwer is more serious for 
>>directories. The more I think I think about it, the more I wonder whether
>>Solaris did things right - having a special operation to "cross the 
>>boundary".
>>
>>I suspect Solaris did it that way because it's a hell of a lot easier to
>>do it like that, but regardless, it would solve the issue of real 
>>directories having both real children _and_ the "extra streams".
>>
>>		Linus
>>
>>
>>  
>>

