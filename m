Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288354AbSANAEg>; Sun, 13 Jan 2002 19:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288351AbSANAE2>; Sun, 13 Jan 2002 19:04:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18438 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288354AbSANAEQ>; Sun, 13 Jan 2002 19:04:16 -0500
Message-ID: <3C422066.6040000@zytor.com>
Date: Sun, 13 Jan 2002 16:03:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: mjustice@austin.rr.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de> <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain> <a1sqd3$nc6$1@cesium.transmeta.com> <200201132309.g0DN9mma018052@sm13.texas.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marvin Justice wrote:

> On Sunday 13 January 2002 02:24 pm, H. Peter Anvin wrote:
> 
>>By the way, expect user programs to fail due to lack of address space
>>if you only give them 1 GB of userspace.  At 1 GB of userspace there
>>is *no* address space which is compatible with the normal address
>>space map available to the user process.
>>
> Actually, I think it will work for apps < `600MB since the mmap area is 
> automatically adjusted to begin at PAGE_OFFSET/3.
> 


As I said: At 1 GB of userspace there is *no* address space which is 
compatible with the normal address space map available to the user process.

There is mmap() space, available, sure, but you can't get the same 
address, even by request.  Applications that care about the layout of 
the address space will fail.

	-hpa

