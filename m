Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTENBwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTENBwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:52:50 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:53784 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261780AbTENBwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:52:49 -0400
Date: Tue, 13 May 2003 19:06:47 -0700
From: Andrew Morton <akpm@digeo.com>
To: Shawn <core@enodev.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
Message-Id: <20030513190647.0c6459af.akpm@digeo.com>
In-Reply-To: <1052877161.3569.17.camel@www.enodev.com>
References: <1052866461.23191.4.camel@www.enodev.com>
	<20030514012731.GF8978@holomorphy.com>
	<1052877161.3569.17.camel@www.enodev.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 02:05:30.0937 (UTC) FILETIME=[4BE5CA90:01C319BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> Not to get away from the praise too much, but I have a rpm/db4 problem
>  that seems to be related to the kernel. before I started backing out
>  parts of 69-mm4, I just wanted to figure out /which/ parts to try
>  backing out.
> 
>  As root, I basically can't use rpm at all. I think it's select() related
>  as strace shows it timing out. The odd thing is that it works great as a
>  non-privileged user.

rpm seems generally flakey sometimes.

remove /var/lib/rpm/__*

Use

	LD_ASSUME_KERNEL=2.2.5 rpm

to get around rpm's O_DIRECT bug.

