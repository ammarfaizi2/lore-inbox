Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275327AbTHGNIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275328AbTHGNIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:08:18 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20855 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S275327AbTHGNIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:08:15 -0400
Date: Thu, 7 Aug 2003 14:09:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile system call on tmpfs
In-Reply-To: <Pine.LNX.4.33.0308071831240.16498-100000@alpha.cpe.ku.ac.th>
Message-ID: <Pine.LNX.4.44.0308071357470.2015-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Theewara Vorakosit wrote:
> 	I use linux redhat 9 with kernal 2.4.20-13.9smp. I try to use
> sendfile system. I found that on ext3 file system, it works fine.
> However, on tmpfs, it error with "Invalid argument". Does sendfile()
> support on tmpfs or other filesystem?

The 2.4 tmpfs did not support sendfile (or loop) until 2.4.22-pre3,
so Red Hat's 2.4.20-13.9smp won't do it.

If you're at ease with patching the kernel source and rebuilding your
kernel, please let me know: I should be able to send you the necessary
patch (mainly mm/shmem.c) to add those features into your Red Hat 9 tmpfs.

Hugh

