Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274222AbRISWQT>; Wed, 19 Sep 2001 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274224AbRISWQO>; Wed, 19 Sep 2001 18:16:14 -0400
Received: from ip35.nsisw.com ([64.132.82.35]:38799 "EHLO xchgind02.nsisw.com")
	by vger.kernel.org with ESMTP id <S274222AbRISWPF> convert rfc822-to-8bit;
	Wed, 19 Sep 2001 18:15:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: broken VM in 2.4.10-pre9
Date: Wed, 19 Sep 2001 17:15:21 -0500
Message-ID: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
Thread-Topic: broken VM in 2.4.10-pre9
Thread-Index: AcFBVdiUiWfrw4OUTte5zrnyifHd9QAAROSQ
From: "Rob Fuller" <rfuller@nsisoftware.com>
To: "David S. Miller" <davem@redhat.com>, <ebiederm@xmission.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my one contribution to this thread I wrote:

"One argument for reverse mappings is distributed shared memory or
distributed file systems and their interaction with memory mapped files.
For example, a distributed file system may need to invalidate a specific
page of a file that may be mapped multiple times on a node."

I believe reverse mappings are an essential feature for memory mapped
files in order for Linux to support sophisticated distributed file
systems or distributed shared memory.  In general, this memory is NOT
anonymous.  As such, it should not affect the performance of a
fork/exec/exit.

I suppose I confused the issue when I offered a supporting argument for
reverse mappings.  It's not reverse mappings for anonymous pages I'm
advocating, but reverse mappings for mapped file data.

> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Wednesday, September 19, 2001 4:56 PM
> To: ebiederm@xmission.com
> Cc: alan@lxorguk.ukuu.org.uk; phillips@bonn-fries.net; Rob Fuller;
> linux-kernel@vger.kernel.org; linux-mm@kvack.org
> Subject: Re: broken VM in 2.4.10-pre9
> 
> 
>    From: ebiederm@xmission.com (Eric W. Biederman)
>    Date: 19 Sep 2001 15:37:26 -0600
>    
>    That I think is a significant cost.
> 
> My own personal feeling, after having tried to implement a much
> lighter weight scheme involving "anon areas", is that reverse maps or
> something similar should be looked at as a latch ditch effort.
> 
> We are tons faster than anyone else in fork/exec/exit precisely
> because we keep track of so little state for anonymous pages.
> 
> Later,
> David S. Miller
> davem@redhat.com
> 
