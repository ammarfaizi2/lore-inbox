Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUBRKh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUBRKhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:37:25 -0500
Received: from agminet04.oracle.com ([141.146.126.231]:27285 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S264361AbUBRKhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:37:23 -0500
Message-ID: <4033404E.1010303@iitbombay.org>
Date: Wed, 18 Feb 2004 16:07:02 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6]  UFS2 Read Only Patch
References: <40332F42.9070605@iitbombay.org> <20040218014422.7a1144b3.akpm@osdl.org>
In-Reply-To: <20040218014422.7a1144b3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
Thanks for the comments.

>> The patch for 2.6.3 is here :
>> http://ufs-linux.sourceforge.net/ufs2/2.6.3/ufs2-read-only-p1.txt
>> http://ufs-linux.sourceforge.net/ufs2/2.6.3/ufs2-read-only-p2.txt
>>    
>>
>
>ooh, I see you have a mkfs.ufs there.  Does it support UFS1 as well?
>
Yeah , it does support UFS1 as well ....

>Does current UFS support little-endian machines?  If so, has this code been
>tested on a little-endian host?  The code _looks_ OK, but one does need to
>test...
>
This patch has been somewhat tested on my "Pentium 4"  machine (running 
RHEL 3).
Other than that , 1-2 persons on freebsd list has also tried this.

>Has the patched filesystem been regression tested against a UFS1 filesystem?
>
Only some most basic (mount , read ) functionality has been cheked to be 
working.

>
>
>The patches which you have there are a bit of a disaster coding-style wise.
>
>- Use hard tabs everywhere, not eight-spaces.
>
>- No space before terminating semicolons
>
>-
>
>+        if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
>+        {
>+	     uspi->s_u2_size  = fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size);
>
>  should be
>
>	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
>
>  etcetera.   See Documentation/CodingStyle.
>
Well .... I will prepare a modifed patch and send that again .

>Thanks.
>
All-in-all , the problem is that this
was not getting enough testing so  I thought that unless it is included
in  , say mm series, it will not get tested.  That's why I send it to you .
But anyway , wait for the modifed version (which will take care of 
Documentation/CodingStyle) .

Niraj


