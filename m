Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSKOXEl>; Fri, 15 Nov 2002 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSKOXEl>; Fri, 15 Nov 2002 18:04:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38590 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266898AbSKOXEj>;
	Fri, 15 Nov 2002 18:04:39 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, kniht@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org, mailing-lists@digitaleric.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE5F968DE.F33233C5-ON85256C72.007E57DF@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Fri, 15 Nov 2002 17:07:27 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/15/2002 06:07:29 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh wrote:
>> If we have to use a 2-level component list, then I'd prefer we
>> do the following:
>>
>> Category = 2.5-linus, 2.5-ac, 2.5-mm, etc.
>> Component = something like
>>       MM-Page allocator
>>       MM-Slab allocator
>>       MM-NUMA
>>       MM-MTTR
>>       MM-Others
>>       FileSys-devfs
>>       FileSys-ext2
>>       FileSys-ext3
>>       and so on...
>
>No. That ends up with 10 billion items all in one drop down list,
>which is a pain in the butt to use.

Well, it's not 10 billion items, but closer to....60 :-)  And
the current component list is pretty complete, right?  We don't
want to add anything that is not included in the official trees.

By the way, have you looked at Red Hat Bugzilla?  They have
several hundreds of components in a single scroll-down list
(they define a component as a package).  Of course, the list is
alphabetical, so it's not too bad to use it.

So I think 60+ is definitely a manageable number.

>
>> The above approach does not require any coding changes in Bugzilla
>> and is therefore preferrable.
>
>The current fix doesn't require coding changes either, and was trivial
>to implement. A long term solution should be done properly, by the
>addition of a tree field.

The approach above does not need any long-term solution.  We should
try to avoid adding too much code above the base Mozilla code base
since it would be tough to upgrade the kernel bugzilla to a later
version of Mozilla code and it would introduce bugs which we don't
want.

Khoa



