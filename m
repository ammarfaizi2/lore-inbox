Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282757AbRLGGV6>; Fri, 7 Dec 2001 01:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282771AbRLGGVs>; Fri, 7 Dec 2001 01:21:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282757AbRLGGVh>; Fri, 7 Dec 2001 01:21:37 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: horrible disk thorughput on itanium
Date: Fri, 7 Dec 2001 06:15:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9upmqm$7p4$1@penguin.transmeta.com>
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de> <Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de>
X-Trace: palladium.transmeta.com 1007706070 32526 127.0.0.1 (7 Dec 2001 06:21:10 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Dec 2001 06:21:10 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de>,
Mike Galbraith  <mikeg@wen-online.de> wrote:
>
>> Andrew Morton <akpm@zip.com.au> writes:
>>
>> As far as I can see bonnie++ doesn't use putc_unlocked, but putc.
>
>Plain old Bonnie suffered from the same thing.  I long ago made it
>use putc_unlocked() here because throughput was horrible otherwise.

Oh, yeah, blame it on bonnie.

	"Our C library 'putc' is horribly sucky"

	"Well, then, use something else then".

Isn't somebody ashamed of glibc and willing to try to fix it? It might
be as simple as just testing a static flag "have I used pthread_create"
or even a function pointer that gets switched around at pthread_create..

"putc()" is a standard function.  If it sucks, let's get it fixed.  And
instead of changing bonnie, how about pinging the _real_ people who
write sucky code?

		Linus
