Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314671AbSEFSrT>; Mon, 6 May 2002 14:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEFSrS>; Mon, 6 May 2002 14:47:18 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:17644 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id <S314671AbSEFSrR>;
	Mon, 6 May 2002 14:47:17 -0400
Message-ID: <3CD6CFB0.FB57BA04@isg.de>
Date: Mon, 06 May 2002 20:47:12 +0200
From: Peter Niemayer <niemayer@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cr@sap.com
Cc: linux-kernel@vger.kernel.org
Subject: unused shared memory is written into core dump - the bug is back 
 again...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Roland wrote:

> > I just noticed that when I attach some SYSV shared memory segments
> > to my process and then that process dies from a SIGSEGV that _all_
> > the shared memory is dumped into the core file, even if it was never
> > used and therefore didn't show up in any of the memory statistics.
> 
> Fixed in recent kernel versions (2.2 and 2.4). It will create sparse
> files and not touch the unused address space.

Well, it was fixed (thanks!) back then in June 2001.

However, the misbehaviour has returned - I can't say exactly when,
but with 2.4.18 it happenes again and just caused my computer to
hang for quite a long time (dumping 10 cores of empty 512 MB per process
takes some time... :-| )

Can you fix it again (and set up a booby-trap in the source that immediately
electro-shocks anyone trying to revert to the old bad habit)? :-)

Regards,

Peter Niemayer
