Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTDPJ7h (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTDPJ7h 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:59:37 -0400
Received: from [12.47.58.203] ([12.47.58.203]:45281 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264280AbTDPJ7g (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 05:59:36 -0400
Date: Wed, 16 Apr 2003 03:11:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: DMA transfers in 2.5.67
Message-Id: <20030416031144.613b0cc7.akpm@digeo.com>
In-Reply-To: <200304160548_MC3-1-349F-E844@compuserve.com>
References: <200304160548_MC3-1-349F-E844@compuserve.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 10:11:22.0195 (UTC) FILETIME=[87D5C230:01C30400]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> # mount /ext3_fs
> # time dd if=/ext3_fs/100MiB_file of=/dev/null bs=32k
> 
>   2.4.20aa1 : 3.3 sec (exactly what I expect to see)
>   2.5.66    : 6.6 sec

With this test 2.4 will leave a lot more unwritten dirty data in memory.

You should include a `sync' in the timings.
