Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWFGWlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWFGWlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWFGWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:41:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932452AbWFGWlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:41:08 -0400
Date: Wed, 7 Jun 2006 15:40:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. =?ISO-8859-1?B?TWFnYWxs824i?= <jamagallon@ono.com>"@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-Id: <20060607154054.cf4f2512.akpm@osdl.org>
In-Reply-To: <20060608003153.36f59e6a@werewolf.auna.net>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 00:31:53 +0200
"J.A. Magallón" <jamagallon@ono.com> wrote:

> WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
> WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
> WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)

Yes, that's a false positive - doing locking from within an __init section.
We need to shut that up somehow.

