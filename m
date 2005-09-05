Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVIEKZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVIEKZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 06:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVIEKZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 06:25:24 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:22361 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750920AbVIEKZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 06:25:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbSS7pmzhXqHwyyBmG/lPrksTRZ7pfKt5td7lICxu60Jnn+Skru6y62S2cBWfYlmyziAcjDGR7LdtaGvwmwBiMlRFCxkUGNA/k1rLT/1fzTcEMDzbsf/ZuwwkNUYF/+13038fYV6puwgnrPB3v2qCIoXNBrCet7bdhGx2ve/IMA=
Message-ID: <21d7e997050905032549e80fb6@mail.gmail.com>
Date: Mon, 5 Sep 2005 20:25:20 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: airlied@gmail.com
To: Emmanuel Fleury <fleury@cs.aau.dk>
Subject: Re: [2.6.13+swsusp2] iounmap Oops
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <431BF0FF.6050402@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431BF0FF.6050402@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Sep  5 08:39:21 hermes vmunix: iounmap: bad address d72f2000
> Sep  5 08:39:21 hermes vmunix:  [<c010e245>] iounmap+0xc5/0xd0
> Sep  5 08:39:21 hermes vmunix:  [<c015161b>] page_remove_rmap+0x3b/0x60
> Sep  5 08:39:21 hermes vmunix:  [<c020c9e8>]
> radeon_do_cleanup_cp+0x348/0x410
> Sep  5 08:39:21 hermes vmunix:  [<c020cef5>] radeon_do_release+0xa5/0x120
> Sep  5 08:39:21 hermes vmunix:  [<c020493a>] drm_takedown+0x2a/0x4f0
> Sep  5 08:39:21 hermes vmunix:  [<c0205d38>] drm_fasync+0x48/0xa0
> Sep  5 08:39:21 hermes vmunix:  [<c02059d2>] drm_release+0x3f2/0x4d0
> Sep  5 08:39:21 hermes vmunix:  [<c015bec1>] __fput+0xa1/0x170
> Sep  5 08:39:21 hermes vmunix:  [<c015a452>] filp_close+0x52/0x90
> Sep  5 08:39:21 hermes vmunix:  [<c015a4e8>] sys_close+0x58/0x60
> Sep  5 08:39:21 hermes vmunix:  [<c0102dc5>] syscall_call+0x7/0xb

Looks like mine, can you send me your /var/log/Xorg.0.log and xorg.conf, 

And if you have a chance can you 
echo 1 > /sys/module/drm/parameters/debug and reproduce and send me dmesg...

Dave.
