Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUIJRvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUIJRvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUIJRvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:51:43 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:20134 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267614AbUIJRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:51:34 -0400
Message-ID: <4141E99F.5060303@namesys.com>
Date: Fri, 10 Sep 2004 10:51:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040825200859.GA16345@lst.de>	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>	 <20040826001152.GB23423@mail.shareable.org>	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>	 <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>	 <20040826140500.GA29965@fs.tum.de>	 <20040826150202.GE5733@mail.shareable.org>	 <41410DE7.3090100@techsource.com>  <41413A2B.9020405@namesys.com> <1094797973.4838.4.camel@almond.st-and.ac.uk> <4141504B.8030104@namesys.com> <4141CCA2.9010005@techsource.com>
In-Reply-To: <4141CCA2.9010005@techsource.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>
>
> Hans Reiser wrote:
>
>> Peter Foldiak wrote:
>>
>>> On Fri, 2004-09-10 at 06:22, Hans Reiser wrote:
>>>  
>>>
>>>> He asked me, why not just access a filename's size as filename/size?
>>>>   
>>>
>>>
>>>
>>> I now understand that you need a way to distinguish between something
>>> like
>>>
>>> shoe/size
>>>
>>> and
>>>
>>> shoe/.../size   (or shoe/..size)
>>>
>>> The first one is the size of the shoe, the second is the automatically
>>> generated size of the file (object). You would get into trouble if you
>>> would not allow the user to use shoe/size for shoe size. Peter
>>>
>>>
>>>
>>>
>>>  
>>>
>> exactly.
>>
>> Of course, problem/shoe/size could refer to shoe size in centimeters 
>> of a problem shoe or the size of the problem relating to a shoe in 
>> units of reporters providing press coverage of it or....
>>
>> So there are lots of opportunities for ambiguity in semantics....
>>
>> Still, widely used builtins seem like they should be moderately 
>> evasive of commonly used names.
>
>
> You know, if tools all need to be rewritten anyway to deal with the 
> file metadata "directory", then why not change the symbol that 
> delimits the metadata key?

because it is useful that it is only a style convention.  Changing the 
symbol makes it mandatory to distinguish metafiles from files.

>
> Everyone likes ':', so we'd have "problem/shoe:size".  (Don't bother 
> to complain about files which have : in them, because I already know 
> it sucks, but it's an example.)
>
> See, unless you can come up with a way to seamlessly make old tools 
> work with the new semantics, then there's no reason not to make more 
> than one change to tools at at the same time.
>
> Also, if you take the ':' example literally, then the file system 
> would need to be able to figure out that a file whose literal name is 
> "C:\MYPR0NDIR\BODY_PARTS.JPG" isn't referring to metadata for a file 
> named "C".  :)
>
>
>

