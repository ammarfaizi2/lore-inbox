Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282502AbRLKSrL>; Tue, 11 Dec 2001 13:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLKSqw>; Tue, 11 Dec 2001 13:46:52 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:11444 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282502AbRLKSqm>; Tue, 11 Dec 2001 13:46:42 -0500
Message-Id: <5.1.0.14.2.20011211184344.04adc9d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Dec 2001 18:46:43 +0000
To: Hans Reiser <reiser@namesys.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Revised extended attributes interface
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com,
        Nikita Danilov <god@namesys.com>
In-Reply-To: <3C164F31.7080404@namesys.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
 <20011207202036.J2274@redhat.com>
 <20011208155841.A56289@wobbly.melbourne.sgi.com>
 <20011210115209.C1919@redhat.com>
 <20011211124115.E70201@wobbly.melbourne.sgi.com>
 <20011211134758.F2268@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:23 11/12/01, Hans Reiser wrote:
>Stephen C. Tweedie wrote:
>The proposal defines two "families" of attribute entities: attribute
>>families and name families.
>>
>>An attribute family might be ATR_USER or ATR_SYSTEM to specify that we
>>are dealing with arbitrary user or system named extended attributes,
>>or ATR_POSIXACL to specify POSIX-semantics ACLs.  Obviously, this can
>>be extended to other ACL semantics without revving the API --- a new
>>attribute family would be all that is needed.
>>
>>The "name family" is the other part of the equation.  Attributes in
>>the ATR_USER or ATR_SYSTEM families might be named with counted
>>strings, so they would have names in the ANAME_STRING name family.
>>POSIX ACLs, however, have a different namespace: ANAME_UID or
>>ANAME_GID.  The API cleanly deals with the difference between user and
>>group ACLs.  It also makes it easy to add support later on for more
>>complex operations: if we want to add NT SID support to ext2 ACLs so
>>that Samba and local accesses get the same access control, we can pass
>>ANAME_NTSID names to the ATR_POSIXACL attribute family without
>>changing the API.
>If you have given it some thought, which your writing hints you may have, 
>can you say a little about supporting NT SIDS and NT ACLs by Linux, and 
>how that can be hard and easy?
>
>One of my programmers is arguing that NT (as opposed to POSIX) ACL support 
>is harder than I imagine due to SIDS, and.... your view would be interesting.

SIDs are nothing but user ids so you just require the user to pass a 
mapping between SIDs and Linux user&group ids at mount time and that 
problem is solved.

I am told samba already has support for SIDs so it can't be that difficult. (-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

