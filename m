Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265543AbUFIFZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbUFIFZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 01:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUFIFZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 01:25:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:42650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265544AbUFIFZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 01:25:04 -0400
Date: Tue, 8 Jun 2004 22:24:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: mason@suse.com, mika.penttila@kolumbus.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback_inodes can race with unmount
Message-Id: <20040608222415.5caaee16.akpm@osdl.org>
In-Reply-To: <20040608202217.0b7a6371.akpm@osdl.org>
References: <1086722523.10973.157.camel@watt.suse.com>
	<40C61A20.4000906@kolumbus.fi>
	<1086725926.10973.161.camel@watt.suse.com>
	<20040608145627.0191c026.akpm@osdl.org>
	<1086744565.10973.192.camel@watt.suse.com>
	<20040608202217.0b7a6371.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Something like this?

No, that's not going to work, is it - we don't hold I_LOCK across the
critical iput().

May have to do it your way, but the trylock is irksome...
