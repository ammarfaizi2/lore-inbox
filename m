Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTDSIkl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 04:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTDSIkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 04:40:41 -0400
Received: from [12.47.58.203] ([12.47.58.203]:55984 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263357AbTDSIkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 04:40:40 -0400
Date: Sat, 19 Apr 2003 01:52:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bash-shared-mapping oops'es on 2.5.66-mm1
Message-Id: <20030419015235.425cd86c.akpm@digeo.com>
In-Reply-To: <m37k9qrjx2.fsf@tmi.comex.ru>
References: <m37k9qrjx2.fsf@tmi.comex.ru>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 08:52:32.0203 (UTC) FILETIME=[03C781B0:01C30651]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> hi!
> 
> [root@proto db2]# /root/tools/bash-shared-mapping -n 5 -t 3 foo 300000000
> 
> on serial console:
> 
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:408!

	if (!PageAnon(page)) {
		if (!page->mapping)
			BUG();
	
Yes, we've had a few reports of that.  You'll need to revert objrmap*.patch
if it's being a problem.

