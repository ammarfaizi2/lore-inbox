Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWDDVCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWDDVCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWDDVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:02:43 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:11341 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750871AbWDDVCm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FWf6mRBykKakPWzvGZ1GEp4KPQsGfbqQqkdZGGq4rB39pivyvQQFbliZhmx/IVBQub5h4CztasfXF4bbWH8EArqqfkj95guyy7Bw4YvOssx0F19ymhEu+W9jHTDF0G7ei1qNnmO87eVlPTCrD0inEbMqb5OIdz+0zyC9psCqcqs=
Message-ID: <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
Date: Tue, 4 Apr 2006 17:02:41 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <4432D6D4.2020102@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
	 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
	 <4432D6D4.2020102@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In that case it would be a normal elevator algorithm and that has a
possiblity of starving the requests at one end of the disk.

- Vishal

On 4/4/06, Bill Davidsen <davidsen@tmr.com> wrote:
> Vishal Patil wrote:
> > Maintain two queues which will be sorted in ascending order using Red
> > Black Trees. When a disk request arrives and if the block number it
> > refers to is greater than the block number of the current request
> > being served add (merge) it to the first sorted queue or else add
> > (merge) it to the second sorted queue. Keep on servicing the requests
> > from the first request queue until it is empty after which switch over
> > to the second queue and now reverse the roles of the two queues.
> > Simple and Sweet. Many thanks for the awesome block I/O layer in the
> > 2.6 kernel.
> >
> Why both queues sorting in ascending order? I would think that one
> should be in descending order, which would reduce the seek distance
> between the last i/o on one queue and the first on the next.
>
> --
>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>   last possible moment - but no longer"  -me
>


--
Every passing minute is another chance to turn it all around.
