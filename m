Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTAaTUU>; Fri, 31 Jan 2003 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTAaTUU>; Fri, 31 Jan 2003 14:20:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:3216 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S261894AbTAaTUS>;
	Fri, 31 Jan 2003 14:20:18 -0500
Message-ID: <3E3ACEA8.8070504@namesys.com>
Date: Fri, 31 Jan 2003 22:29:44 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: conman@kolivas.net, linux-kernel@vger.kernel.org,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
References: <200302010020.34119.conman@kolivas.net>	<3E3A7C22.1080709@namesys.com> <20030131110417.0b70858a.akpm@digeo.com>
In-Reply-To: <20030131110417.0b70858a.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>compilation is not an effective benchmark anymore, not for Linux 
>>filesystems, they are all just too fast (or is it that the compilers are 
>>too slow?....)
>>
>>    
>>
>
>The point of this test is to measure interactions, and fairness.
>
>It answers the question "how much impact does heavy filesystem I/O have upon
>other system activity?".
>
>The "other system activity" in this test is a kernel compile.  That is a
>fairly reasonable metric, because it is sensitive to latencies in servicing
>reads and it is sensitive to inappropriate page replacement decisions.
>
>A more appropriate foreground load might be opening a word processor and
>composing a short letter to Aunt Nellie, but that's harder to automate.  We
>expect that reduced kernel compilation time will correlate with lower-latency
>letter writing.
>
>
>
>  
>
I think the result of the test was that this was not a compelling reason 
for users selecting a particular one of the filesystems because they all 
did well enough at it.  Perhaps because of your code.:)

However,  it is rather interesting for all the reasons you mention.  
There is indeed a tendency for benchmarks to discount the importance of 
latency, and this benchmark does not do that, which is good.  It is 
annoying to be unable to work while a big tar is running in the 
background, but few benchmarks capture that.

We should test reiser4 against this next month, it would be 
interesting.  (It seems we finally fixed the Reiser4 performance problem 
that we hit in August, and now we just need to tweak the CPU usage a bit 
and we'll have something performing pretty decently in our next release....)

-- 
Hans


