Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTI2Qmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTI2Qmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:42:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:31975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263716AbTI2Qmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:42:50 -0400
Date: Mon, 29 Sep 2003 09:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Liviu Voicu <liviuv@savion.cc.huji.ac.il>
Cc: linux-mm@kvack.org, linux-kernel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: zombies
Message-Id: <20030929094330.15485106.akpm@osdl.org>
In-Reply-To: <32F7E536759ED611BBA9001083CFB165C07333@savion.cc.huji.ac.il>
References: <32F7E536759ED611BBA9001083CFB165C07333@savion.cc.huji.ac.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liviu Voicu <liviuv@savion.cc.huji.ac.il> wrote:
>
>  works on but I have zombie processes:
> 
>  liviu@starshooter liviu $ ps axf
>    PID TTY      STAT   TIME COMMAND
>      1 ?        S      0:04 init [3]
>      2 ?        SWN    0:00 [ksoftirqd/0]
>      3 ?        SW<    0:00 [events/0]
>   3158 ?        Z<     0:00  \_ [events/0] <defunct>
>   3162 ?        Z<     0:00  \_ [events/0] <defunct>
>   3331 ?        Z<     0:00  \_ [events/0] <defunct>
>   3333 ?        Z<     0:00  \_ [events/0] <defunct>
>   3512 ?        Z<     0:00  \_ [events/0] <defunct>

ah, OK.  What happens if you do a `patch -R -p1' using
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1/broken-out/call_usermodehelper-retval-fix-2.patch ?
