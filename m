Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVBDX3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVBDX3X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbVBDXT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:19:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263770AbVBDXCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:02:31 -0500
Date: Fri, 4 Feb 2005 15:07:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lincoln Dale <ltd@cisco.com>
Cc: Ian.Godin@lowrydigital.com, linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
Message-Id: <20050204150728.6a697e0e.akpm@osdl.org>
In-Reply-To: <5.1.0.14.2.20050205094038.05323240@171.71.163.14>
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
	<c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
	<5.1.0.14.2.20050205094038.05323240@171.71.163.14>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale <ltd@cisco.com> wrote:
>
> sg_dd uses a window into a kernel DMA window.  as such, two of the four 
> memory acccesses are cut out (1. DMA from HBA to RAM, 2. userspace 
> accessing data).
> 1.6Gbps / 2 = 800MB/s -- or roughly what Ian was seeing with sg_dd.

Right.  That's a fancy way of saying "cheating" ;)

But from the oprofile output it appears to me that there is plenty of CPU
capacity left over.  Maybe I'm misreading it due to oprofile adding in the
SMP factor (25% CPU on a 4-way means we've exhausted CPU capacity).

> DIRECT_IO should achieve similar numbers to sg_dd, but perhaps not quite as 
> efficient.

Probably so.

There are various tools in
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz which are
more useful than dd, btw.  `odread' and `odwrite' are usful for this sort
of thing.


