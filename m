Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTHSW0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTHSW0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:26:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:18131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261421AbTHSW0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:26:49 -0400
Date: Tue, 19 Aug 2003 15:12:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Happe <andreashappe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm2: JFS/cryptoapi OOPS
Message-Id: <20030819151206.0b8c2052.akpm@osdl.org>
In-Reply-To: <slrnbk4hd2.8pm.andreashappe@flatline.ath.cx>
References: <slrnbk4hd2.8pm.andreashappe@flatline.ath.cx>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Happe <andreashappe@gmx.net> wrote:
>
> trying to run 'mkfs.jfs /dev/loop1' on a file backed cryptoloop using
> aes creates following OOPS. System is a P3m, UP with enabled preemption.
> 
> kernel BUG at mm/filemap.c:1930!

It's a bogus check.  Please just delete line 1930 of mm/filemap.c.
