Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSLBSei>; Mon, 2 Dec 2002 13:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSLBSei>; Mon, 2 Dec 2002 13:34:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:62865 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264818AbSLBSed>;
	Mon, 2 Dec 2002 13:34:33 -0500
Message-ID: <3DEBA972.DB6AF8F1@digeo.com>
Date: Mon, 02 Dec 2002 10:41:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 hang when copying files, handwritten trace included
References: <3DEB70FE.C422A3EB@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 18:41:54.0596 (UTC) FILETIME=[7C66F640:01C29A32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> 2.5.50 hung when copying 800M.
> mke2fs on a 10G partition, then try to copy
> the entire /home there. Source and destionation
> was on the same disk. After a while, this happened:
> 
> EIP: wake_up_forked_process+0xb8/0x18c
> EAX: 5a5a5a5a   (suspicious)
> 
> trace:
> do_fork
> kernel_thread
> pdflush
> kernel_thread_helper
> start_one_pdflush_thread
> pdflush
> __pdflush
> __pdflush
> background_writeout
> kernel_thread_helper
> 

Yes please - if you could gather sufficient info to enable
us to determine what eax is pointing at in wake_up_forked_process(),
that would help.  Presumably it's the new process, which is rather
bizarre.

Also, does disabling preemption make it stop?

Thanks.
