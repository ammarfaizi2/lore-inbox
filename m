Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVHYDMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVHYDMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 23:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVHYDMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 23:12:55 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:37507 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S964775AbVHYDMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 23:12:54 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 24 Aug 2005 20:12:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050825031242.GC6079@taniwha.stupidest.org>
References: <200508242241.j7OMfQ1g012200@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508242241.j7OMfQ1g012200@ms-smtp-01.rdc-nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 06:41:26PM -0400, robotti@godmail.com wrote:

> I tried it with kernel 2.6.13-rc5 and it seems to work.

it should yes

> It uses 50% of total memory for tmpfs, but it would be nice to have
> an option (tmpfs_size=90% etc.) that you could pass to the kernel.

that's just because of the tmpfs default; you can remount to change
that if it's not suitable once your up and running in your
init-scripts or whatever


> You need to add this to init/main.c for it to compile.
> #include <asm/uaccess.h>

hmm... really?  i'll rediff it at some point and test it maybe.  i
really don't like the explicity shm init though, i'd like to think of
a cleaner way to do that
