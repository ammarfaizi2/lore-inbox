Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBLXEW>; Mon, 12 Feb 2001 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBLXEM>; Mon, 12 Feb 2001 18:04:12 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:19981 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129047AbRBLXD7>; Mon, 12 Feb 2001 18:03:59 -0500
Date: Mon, 12 Feb 2001 18:03:32 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <386960000.982019012@tiny>
In-Reply-To: <3A884ABE.29F14A5D@namesys.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, February 12, 2001 11:42:38 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

>> Chris,
>> 
>> Do you know if the people reporting the corruption with reiserfs on
>> 2.4 were using IDE drives with PIO mode and IDE multicount turned on?
>> 
>> If so, it may be caused by the problem fixed by Russell King on
>> 2.4.2-pre2.
>> 
>> Without his fix, I was able to corrupt ext2 while using PIO+multicount
>> very very easily.
> 

I suspect the bugfixes in pre2 will fix some of the more exotic corruption
reports we've seen, but this one (nulls in log files) probably isn't caused
by a random (or semi-random) lower layer corruption.  These users are not
seeing random metadata corruption, so I suspect this bug is different (and
reiserfs specific).

> Was the bug you describe also present in the 2.2.* series?  If not, then
> the bugs are not the same.
> 

In 2.2 code the only data file corruption I know if is caused by a crash....

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
