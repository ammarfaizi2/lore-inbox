Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVAPVF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVAPVF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAPVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:05:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:30848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262606AbVAPVFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:05:20 -0500
Date: Sun, 16 Jan 2005 13:04:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       james4765@cwazy.co.uk
Subject: Re: [PATCH 0/13] remove cli()/sti() in drivers/char/*
Message-Id: <20050116130452.10fabe52.akpm@osdl.org>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson <james4765@cwazy.co.uk> wrote:
>
> This series of patches removes the last cli()/sti()/save_flags()/restore_flags()
>  function calls in drivers/char.

I don't see much point in this, really.  Those cli() calls are a big fat
sign saying "broken on smp" and they now generate compile-time warnings
emphasising that.  These drivers still need to be fixed up - we may las
well leave them as-is until someone gets onto doing that.
