Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVGGAXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVGGAXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVGFUFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:07 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:54950 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262209AbVGFSHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:07:51 -0400
Message-ID: <42CC1DEE.7030502@namesys.com>
Date: Wed, 06 Jul 2005 11:07:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a> <87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com> <42CBD7F6.2050203@slaphack.com>
In-Reply-To: <42CBD7F6.2050203@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> And, once we start talking about applications, /meta will be more
> readily supported (as in, some apps will go through a pathname and
> stop when they get to a file, and then there's tar).  On apps which
> don't have direct support for /meta, you'd be navigating to the file
> in question and then manually typing '...' into the dialog, so I don't
> see why typing '...' at the end is better than typing '/meta' or
> '/meta/vfs' at the beginning.

Performance.  If you type it at the end, and you already have done the
lookup of the filename, then you can go from the file to one of its
methods, instead of a complete new traversal of another tree under /meta

>
> That said, I'm still not entirely sure how we get /meta/vfs to work
> other than adding a '...' sort of delimiter anyway.
>
>>> And a question: is it feasible to store, for each inode, its parent(s),
>>> instead of just the hard link count?
>>>
>>>
>>
>> Ooh, now that is an interesting old idea I haven't considered in 20
>> years.... makes fsck more robust too....
>
>
> Doesn't it make directory operations slower, too?

Not sure.  It consumes space though.

>
> And, will it require a format change?
>
Yes, but we have plugins now, so.....

