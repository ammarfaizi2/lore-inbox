Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUESN7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUESN7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUESN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 09:59:34 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:43880 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264182AbUESN7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 09:59:32 -0400
In-Reply-To: <1084973802.27142.14.camel@watt.suse.com>
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org> <200405190453.31844.elenstev@mesatop.com> <1084968622.27142.5.camel@watt.suse.com> <20040519.072009.92566322.wscott@bitmover.com> <40AB5639.7060806@yahoo.com.au> <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov> <1084973802.27142.14.camel@watt.suse.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BEA1FF76-A99C-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: hugh@veritas.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       elenstev@mesatop.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       support@bitmover.com, Wayne Scott <wscott@bitmover.com>,
       adi@bitmover.com, akpm@osdl.org, wli@holomorphy.com,
       Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page?
Date: Wed, 19 May 2004 07:59:28 -0600
To: Chris Mason <mason@suse.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 19, 2004, at 7:36 AM, Chris Mason wrote:

> On Wed, 2004-05-19 at 09:28, Steven Cole wrote:
>
>>> Steven, with all else being equal, you said you found a 2.6.3 SuSE
>>> kernel to significantly outperform 2.6.6, is that right? If so can
>>> you try the same test with plain 2.6.3 please? We'll go from there.
>>
>> Actually, it was a Mandrake kernel, 2.6.3-4mdk IIRC.  Whatever is
>> the default with MDK 10.  One salient difference with the vendor
>> kernel is that everything which can be a module is, and I wasn't
>> using any modules with my kernels.  BTW, I was careful to have the
>> same hdparm settings during the performance testing.
>>
>> The performance difference was very repeatable.  Using the script
>> provided by Andy Isaacson, the 2.6.3-4mdk did the clone in about
>> 11 minutes total, while the various current kernels took about
>> 15 minutes total.  The user times were the same, and the difference
>> was in system time.  Those numbers are from memory, the actual
>> results should be in the archive.
>
> Was this regression only reiserv3 or both v3 and ext3?
>
> -chris
>

I went back through the archive to make sure, and since I didn't
specify where I did the timed tests, those timing tests would have
been done on my /home partition, which is reiserfs v3.

Since I was using different partitions for ext3 and reiserfs on
/dev/hda, a direct comparison between ext3 and reiserfs wouldn't
be completely fair, but a "watching the paint dry" observation
seemed to indicate that reiserfs was significantly faster for this
load.  I did press my backup disk into service for this testing,
to eliminate the possibility that this was due to a finicky disk,
and I have a 3.9 G partition which I've formatted first reiserfs,
then ext3, so I could do some fair tests between reiserfs and
ext3 on that disk.  But I think the results are already known;
reiserfs opens a can of whoopass for this kind of load.

	Steven

