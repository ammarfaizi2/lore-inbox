Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUHZLOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUHZLOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUHZLOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:14:15 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:61325 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268764AbUHZLNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:13:04 -0400
Date: Thu, 26 Aug 2004 13:15:47 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1453776111.20040826131547@tnonline.net>
To: Andrew Morton <akpm@osdl.org>
CC: wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826035500.00b5df56.akpm@osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net>
 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net>
 <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
 <1939276887.20040826114028@tnonline.net>
 <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net>
 <20040826032457.21377e94.akpm@osdl.org> <742303812.20040826125114@tnonline.net>
 <20040826035500.00b5df56.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Spam <spam@tnonline.net> wrote:
>>
>> 
>> 
>> > Spam <spam@tnonline.net> wrote:
>> >>
>> >> 
>> >> 
>> >> > Spam <spam@tnonline.net> wrote:
>> >> >>
>> >> >>    Yes,  for  example  documents,  image  files  etc. The multiple data
>> >> >>    streams  can  contain thumbnails, info about who is editing the file
>> >> >>    (useful for networked files) etc. Could be used for version handling
>> >> >>    and much more.
>> >> 
>> >> > All of which can be handled in userspace library code.
>> >> 
>> >> > What compelling reason is there for doing this in the kernel?
>> >> 
>> >> 
>> >>   Because  having user space tools and code will make it not work with
>> >>   everything. Keeping stuff in the kernel should make the new features
>> >>   transparent to the applications.
>> >> 
>> >>   Applications  that support the new features will benefit, all others
>> >>   will continue to work without destroying data.
>> 
>> > Sorry, but that all sounds a bit fluffy.   Please provide some examples.
>> 
>>   We  already had the examples with cp and mv. Both should continue to
>>   work and the files will still be copied. The same with Konqueror and
>>   Nautilus.  Files  and  their  meta-files/streams/attributes  will be
>>   retained as long as applications are using the OS API.
>> 
>>   However,  if  things  are  to  implemented  in  user-space, then old
>>   applications  will not work correctly and there is risk that all the
>>   extra information will be lost or corrupted.
>> 
>>   You  said  it  would be socially hard. I think it would be very much
>>   close to impossible to get it right. Imagine that Gnome and Nautilus
>>   would  implement  support  for  these. I doubt that cp, mv, KDE, mc,
>>   app-xyz  would  implement  this anytime soon and in the meantime the
>>   data is at risk.
>> 

> No.  All of the applications which you initially identified can be
> implemented by putting the various bits of data into a single file and
> getting applications to agree on the format of that file.

> For example, some image file formats already support embedded metadata, do
> they not?

  Yes, JPEG, TIFF and PNG files for example. But, if you modify any of
  these  with  an application that doesn't support the extensions then
  you will loose them.

  Also,  you  are thinking _very_ narrowly now. There are thousands of
  file  formats.  Implementing  the  support  for  meta-data/ streams/
  attributes  in  the  kernel  will  make  it  possible  to  use  this
  generically for all files.

  I  use  this  in  Windows  quite much. I put information description
  fields  for  lots  of  different  files. These descriptions are then
  searchable etc. I could use the command prompt to copy the files and
  the descriptions would still be there.

  Secondly, do you expect file managers like Nautilus and Konqueror to
  support  every piece of file format on the planet so they could read
  information directly from the documents?

  ~S


