Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbTINUA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 16:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTINUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 16:00:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:10446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261289AbTINUA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 16:00:27 -0400
Date: Sun, 14 Sep 2003 13:00:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
Message-Id: <20030914130041.5b976565.akpm@osdl.org>
In-Reply-To: <3F64C55A.10306@colorfullife.com>
References: <3F644E36.5010402@colorfullife.com>
	<20030914123024.4a261cd3.akpm@osdl.org>
	<3F64C55A.10306@colorfullife.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> What happens if access_ok is used outside of an if statement?

Seems OK.   Even this compiles:

        int x;

        x = likely(y == 0);
