Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUG2VGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUG2VGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUG2VFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:05:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:26799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267425AbUG2VEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:04:22 -0400
Date: Thu, 29 Jul 2004 14:07:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: kladit@t-online.de (Klaus Dittrich)
Cc: linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-Id: <20040729140743.170acb3e.akpm@osdl.org>
In-Reply-To: <20040726150615.GA1119@xeon2.local.here>
References: <20040726150615.GA1119@xeon2.local.here>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kladit@t-online.de (Klaus Dittrich) wrote:
>
> >Can you narrow the onset of the problem down to any particular kernel
> >snapshot?
> 
> Did it and here is the answer.
> 
> kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
> kernels starting with 2.6.7-bk8 did not.

I can reproduce this oom btw.  Am (very, very slowly) working out what's
causing it.  It's unrelated to the vfs-cache-pressure patch.  I'd hope to
have it fixed up for 2.6.8. 
