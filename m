Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbUJ0SWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUJ0SWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUJ0SWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:22:05 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:41488 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262609AbUJ0SPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:15:11 -0400
Date: Thu, 28 Oct 2004 02:13:13 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Alasdair G Kergon <agk@redhat.com>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com,
       christophe@saout.de, Linux Kernel <linux-kernel@vger.kernel.org>,
       bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
In-Reply-To: <20041027154255.GB9937@agk.surrey.redhat.com>
Message-ID: <Pine.LNX.4.61.0410280211240.26933@silk.corp.fedex.com>
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net>
 <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com>
 <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org>
 <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org>
 <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
 <20041027154255.GB9937@agk.surrey.redhat.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/28/2004
 02:15:02 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/28/2004
 02:15:08 AM,
	Serialize complete at 10/28/2004 02:15:08 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Oct 2004, Alasdair G Kergon wrote:

> On Wed, Oct 27, 2004 at 08:41:46AM +0200, Jens Axboe wrote:
>> --- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51.866931262 +0200
>> +++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:41:20.292172299 +0200
>> @@ -987,8 +987,8 @@
>>  	isize = i_size_read(inode);
>
> Can that return 0?

This may not be the problem coz' the bug still exists using vanilla 
2.6.10-rc1, and there's no "isize" in fs/direct-io.c

Thanks,
Jeff.
