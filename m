Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281346AbRKLIhK>; Mon, 12 Nov 2001 03:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281347AbRKLIg6>; Mon, 12 Nov 2001 03:36:58 -0500
Received: from sun.fadata.bg ([80.72.64.67]:57097 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S281346AbRKLIgq>;
	Mon, 12 Nov 2001 03:36:46 -0500
To: Mathijs Mohlmann <mathijs@knoware.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix loop with disabled tasklets
In-Reply-To: <Pine.BSI.4.05L.10111120843291.9564-100000@utopia.knoware.nl>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.BSI.4.05L.10111120843291.9564-100000@utopia.knoware.nl>
Date: 12 Nov 2001 10:07:24 +0200
Message-ID: <878zdcl8eb.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mathijs" == Mathijs Mohlmann <mathijs@knoware.nl> writes:

Mathijs> On 11 Nov 2001, Momchil Velikov wrote:
>> You may want to have a look at the following patches (tested by
>> visual inspection):

Mathijs> I like this one. I think it is what Andrea was going for,
Mathijs> without the changes to interrupt.h. If we are going for

In this patch, the first thing is to deschedule the tasklet. So, the
changes to interrupt.h are needed in order to put back the tasklet in
the queue.

Mathijs> thisone we should add some comments to interrupt.h warning
Mathijs> about deadlocks etc.

What deadlocks ? ;)

Mathijs> still working on a patch that adds a cpu field to the
Mathijs> tasklet_struct.  Looking for races takes me a long time :).

I think we can ignore the cpu whenever a tasklet is scheduled and
disabled, treating it as not scheduled at all.

Regards,
-velco
