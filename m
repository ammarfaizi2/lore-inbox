Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSEVVUE>; Wed, 22 May 2002 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSEVVUD>; Wed, 22 May 2002 17:20:03 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29330 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312558AbSEVVUB>; Wed, 22 May 2002 17:20:01 -0400
Date: Wed, 22 May 2002 14:18:54 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <384590000.1022102334@flay>
In-Reply-To: <20020522203024.GZ2035@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The solution really is a "don't do it then" kind of thing. If you have 
>> 5000 processes that all want to map a big shared memory area, and you 
>> don't want to upgrade your CPU's, it's a _whole_ lot easier to just have a 
>> magic "map_large_page()" system call, and start using the 2MB page support 
>> of the x86.
> 
> map_large_page() sounds decent, though I don't really know how easy
> it'll be to get apps to cooperate. I suspect it's easier when the
> answer is "the app crashed" as opposed to "the kernel crashed".

If we could get the apps (well, Oracle) to co-operate, we could just use
clone ;-) Having this transparent for shmem segments would be really nice.

M.

