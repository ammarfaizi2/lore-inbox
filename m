Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282495AbRLKSZV>; Tue, 11 Dec 2001 13:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282497AbRLKSZM>; Tue, 11 Dec 2001 13:25:12 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:32010 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S282495AbRLKSY7>; Tue, 11 Dec 2001 13:24:59 -0500
Message-ID: <3C164F31.7080404@namesys.com>
Date: Tue, 11 Dec 2001 21:23:45 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com, Nikita Danilov <god@namesys.com>
Subject: Re: [PATCH] Revised extended attributes interface
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com> <20011211124115.E70201@wobbly.melbourne.sgi.com> <20011211134758.F2268@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>
>
>The proposal defines two "families" of attribute entities: attribute
>families and name families.
>
>An attribute family might be ATR_USER or ATR_SYSTEM to specify that we
>are dealing with arbitrary user or system named extended attributes,
>or ATR_POSIXACL to specify POSIX-semantics ACLs.  Obviously, this can
>be extended to other ACL semantics without revving the API --- a new
>attribute family would be all that is needed.
>
>The "name family" is the other part of the equation.  Attributes in
>the ATR_USER or ATR_SYSTEM families might be named with counted
>strings, so they would have names in the ANAME_STRING name family.
>POSIX ACLs, however, have a different namespace: ANAME_UID or
>ANAME_GID.  The API cleanly deals with the difference between user and
>group ACLs.  It also makes it easy to add support later on for more
>complex operations: if we want to add NT SID support to ext2 ACLs so
>that Samba and local accesses get the same access control, we can pass
>ANAME_NTSID names to the ATR_POSIXACL attribute family without
>changing the API.
>
If you have given it some thought, which your writing hints you may 
have, can you say a little about supporting NT SIDS and NT ACLs by 
Linux, and how that can be hard and easy?

One of my programmers is arguing that NT (as opposed to POSIX) ACL 
support is harder than I imagine due to SIDS, and.... your view would be 
interesting.

Hans

