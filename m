Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbSK3OiS>; Sat, 30 Nov 2002 09:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSK3OiS>; Sat, 30 Nov 2002 09:38:18 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:63156 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267252AbSK3OiR>;
	Sat, 30 Nov 2002 09:38:17 -0500
Date: Sat, 30 Nov 2002 15:45:41 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021130144541.GA2517@werewolf.able.es>
References: <20021129233807.GA1610@werewolf.able.es> <3DE80AB6.611F3A8C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3DE80AB6.611F3A8C@digeo.com>; from akpm@digeo.com on Sat, Nov 30, 2002 at 01:47:50 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.30 Andrew Morton wrote:
>"J.A. Magallon" wrote:
>> 
>> - Orlov inode allocator for 2.4
>
>The Orlov allocator in 2.5 has caused a tremendous performance regression
>in dbench-on-ext3/ordered-on-scsi.
>
>I don't know why yet - I doubt if it's due to the allocator itself - more
>likely an IO scheduling bug in ext3, or a bug in the 2.5 elevator.
>
>There is no such regression on IDE - presumably write caching is covering
>up the problem.
>

Is there any way I can test that ? I have all scsi drives and can
for example remount with 'orlov' or 'oldalloc'...

>So that's something to watch out for.
>
>(where did your Orlov patch from?  All the tabs are mangled)
>

See the other answer to previous message...

>You'll need to port this missing bit, which provides the `oldalloc'
>and `orlov' mount options.
>

Thanks, I will add it...
BTW, who puts names to options ? Wouldn't be more intuitive to add options
like 'ialloc_std' or 'ialloc_orlov' ? Too late to change this ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
