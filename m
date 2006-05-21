Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWEUJbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWEUJbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWEUJbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:31:42 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:49559 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751513AbWEUJbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:31:41 -0400
Message-ID: <014601c67cb9$4f235f30$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 11:31:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Chris Wedgwood" <cw@f00f.org>
To: "Haar J?nos" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 11:10 AM
Subject: Re: swapper: page allocation failure.


> On Sun, May 21, 2006 at 11:03:33AM +0200, Haar J?nos wrote:
>
> > MemTotal:      2073048 kB
> > MemFree:       1179376 kB
>
> fine
>
> > Buffers:        829764 kB
>
> ok
>
> > Cached:          19896 kB
> > SwapCached:          0 kB
> > Active:          15604 kB
>
> > Inactive:       837636 kB
>
> hrm
>
> > HighTotal:     1179584 kB
> > HighFree:      1154736 kB
>
> krm
>
> > LowTotal:       893464 kB
> > LowFree:         24640 kB
>
> bad
>
> > SwapTotal:           0 kB
> > SwapFree:            0 kB
>
> ok
>
> > Dirty:           21352 kB
>
> ok
>
> > Writeback:           0 kB
> > Mapped:           7000 kB
> > Slab:            22612 kB
>
> ok
>
>
>
>
> you have very little low
>
>
> > Not installed.
>
> urgh
>
> > Wich package or where can i find the source? (i use redhat 9.0)
>
> google i guess, i have very little idea how to drive RH to be honest
>
> anyhow, it's not the slab

I found it already, thanks.

>
>
> something is eating/using/leaking all your lowmemory
>
>
> what kernel version is this?

[root@st-0001 /]# uname -a
Linux st-0001 2.6.17-rc3-git1 #2 SMP Sun May 21 01:12:22 CEST 2006 i686 i686
i386 GNU/Linux

> how long has the machine been up?

[root@st-0001 /]# uptime
 11:22:10 up  2:52,  1 user,  load average: 0.35, 0.42, 0.43



> do you see it get worse over time?

No.
This is a simple disk node.
It serves the md0 array, and uses mem for buffering-caching.
If it reboots, fill the memory on the first couple of minutes, and stay on
full, but this is relatively good.

But 2 question is remaining:

1. why don't use highmem for caching?
2. why can not allocate enough lowmem from shared-buffer for the e1000
driver if it needs some memory?

Cheers,
Janos

>

