Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTDSER5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 00:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTDSER5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 00:17:57 -0400
Received: from [12.47.58.203] ([12.47.58.203]:61091 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263348AbTDSER4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 00:17:56 -0400
Date: Fri, 18 Apr 2003 21:29:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: "J. Hidding" <J.Hidding@student.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67-mm4] Can't open pty's
Message-Id: <20030418212949.2b9a7d6e.akpm@digeo.com>
In-Reply-To: <web-6774367@mail.rug.nl>
References: <web-6774367@mail.rug.nl>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 04:29:47.0718 (UTC) FILETIME=[4F69FE60:01C3062C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J. Hidding" <J.Hidding@student.rug.nl> wrote:
>
> Hi,
> 
> Xterm (nor any other VT) won't run on my freshly compiled 
> 2.5.67-mm4 kernel. It says:
> 
> --
> xterm: Error 32, errno 2: No such file or directory
> Reason: get_pty: not enough ptys

Apparently you now need to mount the devpts filesystem on /dev/pts.

Red Hat 8's /etc/fstab has

	none /dev/pts devpts gid=5,mode=620 0 0



