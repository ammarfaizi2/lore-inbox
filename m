Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRBRBth>; Sat, 17 Feb 2001 20:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRBRBt1>; Sat, 17 Feb 2001 20:49:27 -0500
Received: from [208.179.59.198] ([208.179.59.198]:57396 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132484AbRBRBtM>; Sat, 17 Feb 2001 20:49:12 -0500
Message-ID: <3A8F29C5.7000302@kalifornia.com>
Date: Sat, 17 Feb 2001 17:47:49 -0800
From: David <david@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac17 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org,
        reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
In-Reply-To: <1217040000.982455419@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can say "me too" for this.  I thought it was perhaps glibc or binutils 
tho.  I only have reiserfs systems now so I don't have a basis for 
comparison.

However I -can- say that I didn't experience this until I put glibc 
2.2.1 on my systems.  I do use an "approved" gcc, stock 2.95.2.

I wouldn't be so quick to pin it on reiserfs.

-d


Chris Mason wrote:

> 
> On Saturday, February 17, 2001 05:21:18 PM +0100 Frank de Lange
> <frank@unternet.org> wrote:
> 
>> Hi'all,
>> 
>> Well, subject says it all... When I try to compile mozilla (CVS version)
>> with the '--enable-elf-dynstr-gc' option, the compile fails with a
>> segfault:
>> 
>> ../../dist/bin/elf-dynstr-gc ../../dist/lib/components/libsample.so
>> make[2]: *** [install] Segmentation fault (core dumped)
>> 
> 
> That's not good.  Which compiler did you use to compile the kernel?  This
> sounds lame, but reiserfs exercises the cpu/mem more than ext2, so we hit
> bad ram more often.  If we run out of other things to try, please run a
> memory tester.
> 
>> compiling the same codebase on an ext2 filesystem does not produce this
>> segfault. When I compare the produced library (libsample.so), there is a
>> consistent difference between the one compile on the reiserfs and the ext2
>> filesystem. Running objdump on the reiserfs-compiled library also produces
>> errors (some assertion failures, a lot of 'invalid string offset' errors,
>> and finally a 'Memory exhausted' error), while objdump happily
>> disassebles the ext-produced binary.
>> 
> 
> Where in the libsample.so file are the differences (what byte offset?).
> Are they restricted to a given range, or do they vary randomly?
> 
>> These problems occur on:
>> 
>>  2.4.1
>>  2.4.2-pre4
>>  2.4.2-pre4 with Chris Mason's 'reiserfs fix for null bytes in small
>>  files'
>> 
> At least the patch didn't make it worse.  Would anyone care to comment on
> how the elf-dynstr-gc option changes the file access patterns for the
> compile?
> 
> thanks,
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



