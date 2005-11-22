Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVKWPvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVKWPvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVKWPvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:51:06 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:23715 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751150AbVKWPur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:50:47 -0500
Message-ID: <43838B69.8020701@tmr.com>
Date: Tue, 22 Nov 2005 16:19:37 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Adams <cmadams@hiwaay.net>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: what is our answer to ZFS?
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <1132690779.20233.74.camel@localhost.localdomain> <20051122195652.GB660478@hiwaay.net>
In-Reply-To: <20051122195652.GB660478@hiwaay.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Adams wrote:
> Once upon a time, Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> 
>>It was a nice try but there is a giant gotcha most people forget. Its
>>only safe to make this assumption while you have all of the
>>files/directories in question open.
> 

Right, at the time the structures were created removable (in any sense) 
media usually meant 1/2 inch mag tape, not block storage. The inode was 
pretty well set by SysIII, IIRC.
> 
> Tru64 adds a "st_gen" field to struct stat.  It is an unsigned int that
> is a "generation" counter for a particular inode.  To get a collision
> while creating and removing files, you'd have to remove and create a
> file with the same inode 2^32 times while tar (or whatever) is running.
> Here's what stat(2) says:
> 
>   Two structure members in <sys/stat.h> uniquely identify a file in a file
>   system: st_ino, the file serial number, and st_dev, the device id for the
>   directory that contains the file.
> 
>   [Tru64 UNIX]  However, in the rare case when a user application has been
>   deleting open files, and a file serial number is reused, a third structure
>   member in <sys/stat.h>, the file generation number, is needed to uniquely
>   identify a file. This member, st_gen, is used in addition to st_ino and
>   st_dev.
> 
Shades of VMS! Of course that's not unique, I believe iso9660 (CD) has 
versioning which is almost never used.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

