Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUGAWyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUGAWyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266350AbUGAWyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:54:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:7302 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266344AbUGAWyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:54:12 -0400
Date: Thu, 1 Jul 2004 15:56:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: root@chaos.analogic.com
Cc: seb@highlab.com, linux-kernel@vger.kernel.org
Subject: Re: io priorities?
Message-Id: <20040701155637.74af8c0d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0407011456110.1241@chaos>
References: <E1Bg64T-0003MC-00@highlab.com>
	<Pine.LNX.4.53.0407011456110.1241@chaos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> Periodically fsync() the logs so there isn't soooo much stuff to
> write. In fact, a simple sync() call about once every few seconds
> should make everything work,

Yup.  Alternatively, set /proc/sys/vm/dirty_ratio and /proc/sys/vm/dirty_background_ratio
to really small values.  Say, 2 and 1.
