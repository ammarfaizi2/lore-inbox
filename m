Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315624AbSEIGCr>; Thu, 9 May 2002 02:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315626AbSEIGCq>; Thu, 9 May 2002 02:02:46 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:33042 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315624AbSEIGCq>; Thu, 9 May 2002 02:02:46 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205060811360.2540-100000@home.transmeta.com>
	<87n0va0yf0.fsf@enki.rimspace.net> <3CD9FC4C.CDF47565@zip.com.au>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Thu, 09 May 2002 16:02:38 +1000
Message-ID: <87pu05q2o1.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2002, Andrew Morton wrote:
> Daniel Pittman wrote:
>> On Mon, 6 May 2002, Linus Torvalds wrote:
>> > On Mon, 6 May 2002, Daniel Pittman wrote:
>> >>
>> >> From the look of the changelog at least a few of the file
>> >> corruption bugs with ext3, 2k block file systems and 2.5 have been
>> >> fixed. Should I expect this release to address the problems I was
>> >> seeing?
>> >
>> > "Expect" is too strong a word. I'd say "hope" - a number of
>> > truncate bugs were fixed, but whether that was what bit you, nobody
>> > knows.
>> >
>> > I suspect the real answer is that we'd love for you to test things
>> > out, but that if it ends up being too painful to recover if the
>> > problems happen again, you probably shouldn't..
>> 
>> Right. I got brave enough to test it on a real, live system after
>> extensive fake testing. It seems to work well, at least so far as
>> running the same workload that cause massive file corruption
>> correctly.
> 
> hmm.

Not conclusive, I know, but getting a panic after a brief test stopped
it at that point. :)

>> So, I believe that 2.5.14 is working correctly with 2k ext3
>> filesystems, at least for minimal use. I didn't do any sort of
>> extreme load testing or anything like that, being cautious about it.
> 
> I've been testing 2.5.14 pretty hard for a couple of days.

[...]

> ext3-journalled is not happy.

Which probably explains my error, then, as I have not stepped back from
data journaled mode on my system.

[...]

> There's a known race between unmount and writeback which is probably
> impossible to trigger.  (see the FIXME at __sync_list).  Testing the
> fix for that at present.

Well, unmount wouldn't have happened for quite a long time in the
shutdown process, given it was at the initial 'send SIGTERM' stage...

[...]

> So unless you're a JFS or ext3-journalled user, 2.5.14 is OK.

The latter. Ah, well, at least you know. 

[...]

> 04 60 -> line 1120.  Yup, I get that one too.  I assume you were
> testing with data=journal.

Confirmed.
        Daniel

-- 
No, no, you're not thinking, you're just being logical.
        -- Niels Bohr
