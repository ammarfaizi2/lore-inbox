Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUFIEKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUFIEKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 00:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUFIEKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 00:10:35 -0400
Received: from web51807.mail.yahoo.com ([206.190.38.238]:38056 "HELO
	web51807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265521AbUFIEKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 00:10:33 -0400
Message-ID: <20040609041032.96600.qmail@web51807.mail.yahoo.com>
Date: Tue, 8 Jun 2004 21:10:32 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: slow down in 2.6 vs 2.4
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1086744927.40c6695f9c361@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, there is an important bit of information missing,
the test is compiling gcc-3.4.0 using gcc-3.2.3 with
binutils-2.13.2.1.  The machine used is a dual 2.8GHz
Xeon w/8G RAM (no ht).

config line is --enable-languages=c,c++
--prefix=/usr/tmp/foo

BTW, the unit never swaps when building.

Thanks!
Phy

--- Con Kolivas <kernel@kolivas.org> wrote:
> 
> Hi Phy
> 
> You said:
> Over the last two days I have been struggling with
> understanding why 2.6.x kernel is slower than
> 2.4.21/23 kernels.  I think I have a test case which
> demostrates this issue.
> make times:
> 
> 2.4.21:
> 323.68user 56.07system 6:35.77elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs
> (3138783major+3818347minor)pagefaults
> 0swaps
> 
> 2.6.7-rc3-s63 (SPA scheduler):
> 334.01user 69.86system 7:01.47elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13301major+6931745minor)pagefaults
> 0swaps
> 
> 2.6.7-rc3:
> 336.17user 68.41system 7:02.47elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13301major+6931745minor)pagefaults
> 0swaps
> 
> 
> ----
> Your 2.4 compile is showing a massive number of
> major page faults. Just how big
> is this compile you do? Can you try running the 2.6
> compile with 
> 
> echo 100 > /proc/sys/vm/swappiness
> 
> Con
> 


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
