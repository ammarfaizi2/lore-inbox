Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUESOUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUESOUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUESOUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:20:55 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:35956 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264192AbUESOUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:20:53 -0400
In-Reply-To: <1084975701.27142.25.camel@watt.suse.com>
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org> <200405190453.31844.elenstev@mesatop.com> <1084968622.27142.5.camel@watt.suse.com> <20040519.072009.92566322.wscott@bitmover.com> <40AB5639.7060806@yahoo.com.au> <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov> <1084973802.27142.14.camel@watt.suse.com> <BEA1FF76-A99C-11D8-A7EA-000A95CC3A8A@lanl.gov> <1084975701.27142.25.camel@watt.suse.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B8B18037-A99F-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: hugh@veritas.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       elenstev@mesatop.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       support@bitmover.com, Wayne Scott <wscott@bitmover.com>,
       adi@bitmover.com, akpm@osdl.org, wli@holomorphy.com,
       Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page?
Date: Wed, 19 May 2004 08:20:47 -0600
To: Chris Mason <mason@suse.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 19, 2004, at 8:08 AM, Chris Mason wrote:

> On Wed, 2004-05-19 at 09:59, Steven Cole wrote:
>
>> I went back through the archive to make sure, and since I didn't
>> specify where I did the timed tests, those timing tests would have
>> been done on my /home partition, which is reiserfs v3.
>>
>> Since I was using different partitions for ext3 and reiserfs on
>> /dev/hda, a direct comparison between ext3 and reiserfs wouldn't
>> be completely fair, but a "watching the paint dry" observation
>> seemed to indicate that reiserfs was significantly faster for this
>> load.  I did press my backup disk into service for this testing,
>> to eliminate the possibility that this was due to a finicky disk,
>> and I have a 3.9 G partition which I've formatted first reiserfs,
>> then ext3, so I could do some fair tests between reiserfs and
>> ext3 on that disk.  But I think the results are already known;
>> reiserfs opens a can of whoopass for this kind of load.
>
> While this is the kind of thing I like to hear, it wasn't really what I
> was asking ;-)
>
> There was a regression between a 2.6.3 mandrake kernel and 2.6.6, was
> this regression just for reiserfs or was it for all filesystems?
>
> If just reiserfs, it might be from the data=ordered and logging changes
> that went into 2.6.6, so I'm quite interested in figuring things out.
>
> -chris

Sorry for distracting you with the second paragraph, but to reemphasize
the first paragraph, I did the timing comparisons between the
various kernel versions on reiserfs v3 _only_, and the /home reiserfs
wasn't mounted with anything special.  I don't have the /etc/fstab
right here in front of me, but I can get that later if needed.  The
.config file was posted in the very first post of this thread, and
the only deviations from that were to add some DEBUG config options
suggested by Andrew or Linus and I dropped PREEMPT (before your patch) 
to
keep the thing from going splaat.

The kernel versions I tested were 2.6.6-current a few days ago,
2.6.3-4mdk, and 2.6.5-aa5.

	Steven

