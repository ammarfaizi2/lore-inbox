Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSEVSf4>; Wed, 22 May 2002 14:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSEVSfu>; Wed, 22 May 2002 14:35:50 -0400
Received: from host.greatconnect.com ([209.239.40.135]:41989 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S316668AbSEVSfJ>; Wed, 22 May 2002 14:35:09 -0400
Message-ID: <3CEBE38A.8020808@rackable.com>
Date: Wed, 22 May 2002 11:29:30 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Weigle <ehw@lanl.gov>
CC: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: Re: Safety of -j N when building kernels?
In-Reply-To: <20020522165320.GC18059@lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   The only major issue I've seen is the build may fail if you run out 
of file handles, or other resources.  The build will fail with an 
"unable to fork" error.  When I was at VA Linux I often compiled kernel 
for use with a make -j 16, or -j 8.  I seem to remember having to play 
with ulimit, and /proc/?/file-max to get enough file handles.


PS- You should also consider logging the output of your compile to a 
file.  As your other jobs will continue for sometime before the make 
fails.  Often preventing you from easily finding the actual compile error.

Eric Weigle wrote:
> Ok, stupid question of the moment-
> 
> I always read about the kernel compilation benchmarks people run on the
> ultra-snazzy new machines, but do people actually run the kernels thus
> generated?
> 
> I have visions of a process being backgrounded to generate some files, and
> not completing before the one of the old files gets linked into the kernel
> (because not all files were listed as dependencies, for example).
> 
> So are the kernel's current Makefiles really SMP safe -- can one really
> run multiple jobs when building Linux kernels? Any horror stories, or am
> I just paranoid?
> 
> 
> Thanks
> -Eric
> 


