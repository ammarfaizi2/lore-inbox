Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTJHVCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTJHVCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:02:16 -0400
Received: from rth.ninka.net ([216.101.162.244]:3489 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261780AbTJHVCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:02:15 -0400
Date: Wed, 8 Oct 2003 14:02:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup of compat_ioctl functions
Message-Id: <20031008140207.666a62c9.davem@redhat.com>
In-Reply-To: <200310082226.15104.arnd@arndb.de>
References: <200310081809.42859.arnd@arndb.de>
	<20031008192929.GC1035@elf.ucw.cz>
	<200310082226.15104.arnd@arndb.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003 22:26:15 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Well, in the light of 'strictly bug fixes only', it was probably too
> much search&replace already. I guess I'll have to prepare a new patch 
> that just fixes the bugs in the current s390 compat_ioctl code and not 
> use fs/compat_ioctl.c in 2.6.0.

That doesn't make any sense, the fact that fs/compat_ioctl.c isn't
using the proper compat user pointer accessor macros is a bug,
so just fix that.

It defeats the whole purpose of this compat layer if people still
need to duplicate the code in some cases.
