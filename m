Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318894AbSHMAsM>; Mon, 12 Aug 2002 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318895AbSHMAsM>; Mon, 12 Aug 2002 20:48:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17418 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318894AbSHMAsL>;
	Mon, 12 Aug 2002 20:48:11 -0400
Message-ID: <3D5857A4.FE358FA2@zip.com.au>
Date: Mon, 12 Aug 2002 17:49:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> ...
> > You can make 2.5 use the 2.4 settings with
> >
> > cd /proc/sys/vm
> > echo 30 > dirty_background_ratio
> > echo 60 > dirty_async_ratio
> > echo 70 > dirty_sync_ratio
> 
> These settings bring -akpm in line with stock 2.5.31, but they are both
> still slower than 2.4.19 (which itself could do better, I think).

In that case I'm confounded.  It worked sweetly for me.  Just

	wget ftp://other-machine/600-meg-file

on a machine booted with mem=160m.  Took 63 seconds over 100bT,
steady column of writes in vmstat.

Which ftp client are you using?  And can you strace it, to see how
much data it's writing per system call?
