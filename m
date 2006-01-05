Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWAEFPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWAEFPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWAEFPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:15:15 -0500
Received: from waste.org ([64.81.244.121]:65236 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751929AbWAEFPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:15:14 -0500
Date: Wed, 4 Jan 2006 23:09:20 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
Subject: Re: [PATCH 0/20] inflate: refactor boot-time inflate code
Message-ID: <20060105050920.GF3356@waste.org>
References: <1.150843412@selenic.com> <20060104195057.75ab3fe1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104195057.75ab3fe1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 07:50:57PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > This is a refactored version of the lib/inflate.c:
> 
> allnoconfig fails:
> 
> lib/lib.a(inflate.o)(.text+0x1f): In function `flush_output':
> : undefined reference to `crc32_le'

Ahh, right. As we always support compressed initramfs, and
decompression always uses CRC, optional/modular CRC support doesn't
really make sense.

Drop patch 20/20 for now, I'll send something better shortly.

-- 
Mathematics is the supreme nostalgia of our time.
