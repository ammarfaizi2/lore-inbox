Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTE1WxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTE1WxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:53:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40569 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261450AbTE1Www (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:52:52 -0400
Date: Wed, 28 May 2003 16:03:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org, solarz@wsisiz.edu.pl
Subject: Re: Slocate/backup, big load on 2.4.X
Message-Id: <20030528160343.78980b13.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.53.0305281852220.2970@lt.wsisiz.edu.pl>
References: <Pine.LNX.4.53.0305281852220.2970@lt.wsisiz.edu.pl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 23:06:08.0390 (UTC) FILETIME=[B91DB260:01C3256D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl> wrote:
>
> After 12 hours of reboot, when updatedb is running or backup via amanda,
> system "get" very high load,

High load isn't necesarily a problem - it just means that a lot of
processes are waiting on disk I/O.  Because updatedb is flogging the disks.

Do a full "ps aux" listing and you'll probably see lots of processes in "D"
state, waiting for the disk head to seek across and read whatever it is
they are trying to read.

