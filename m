Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbRL0T2n>; Thu, 27 Dec 2001 14:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286519AbRL0T2c>; Thu, 27 Dec 2001 14:28:32 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:23563 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286517AbRL0T2Z>; Thu, 27 Dec 2001 14:28:25 -0500
Message-ID: <3C2B75B3.4DEF90D3@zip.com.au>
Date: Thu, 27 Dec 2001 11:25:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersg@0x63.nu
CC: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au>,
		<3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andersg@0x63.nu wrote:
> 
> not much... lets have a look at lvm_do_vg_create then:
> 
> with my patch:
> 0x1830 <lvm_do_vg_create>:         sub    $0x20,%esp
> 
> without my patch:
> 0x1830 <lvm_do_vg_create>:         sub    $0x11c4,%esp
> 
> whoa! 0x11c4
> 
> thats a LOT! much more than sizeof(lv_t)
> 

With egcs-1.1.2:

0xc02546c7 <lvm_do_vg_create+3>:        sub    $0x1d4,%esp

So perhaps we have a compiler problem.  Which version of the
compiler are you using?   Have you verified that sizeof(lv_t)
is really around 420 bytes in your setup?


-
