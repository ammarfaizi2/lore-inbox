Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbRBAEGi>; Wed, 31 Jan 2001 23:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbRBAEG2>; Wed, 31 Jan 2001 23:06:28 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:52239 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129121AbRBAEGO>; Wed, 31 Jan 2001 23:06:14 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E6.001674D4.00@d73mta03.au.ibm.com>
Date: Thu, 1 Feb 2001 09:29:04 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Hi,
>
>On Wed, Jan 31, 2001 at 07:28:01PM +0530, bsuparna@in.ibm.com wrote:
>>
>> Do the following modifications to your wait queue extension sound
>> reasonable ?
>>
>> 1. Change add_wait_queue to add elements to the end of queue (fifo, by
>> default) and instead have an add_wait_queue_lifo() routine that adds to
the
>> head of the queue ?
>
>Cache efficiency: you wake up the task whose data set is most likely
>to be in L1 cache by waking it before its triggering event is flushed
>from cache.
>
>--Stephen

Valid point.


_______________________________________________
Kiobuf-io-devel mailing list
Kiobuf-io-devel@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/kiobuf-io-devel



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
