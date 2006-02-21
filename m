Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWBULhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWBULhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWBULhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:37:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932694AbWBULhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:37:45 -0500
Date: Tue, 21 Feb 2006 03:36:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-Id: <20060221033605.1518ceab.akpm@osdl.org>
In-Reply-To: <20060221113055.GF5733@linuxhacker.ru>
References: <20060220221948.GC5733@linuxhacker.ru>
	<20060220215122.7aa8bbe5.akpm@osdl.org>
	<20060221113055.GF5733@linuxhacker.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@linuxhacker.ru> wrote:
>
>   Introduce FMODE_EXEC file flag, to indicate that file is being opened for
>    execution. This is useful for distributed filesystems to maintain consistent
>    behavior for returning ETXTBUSY when opening for write and execution
>    happens on different nodes.

You forgot something.

Are other clustered/distributed filesystems likely to need something like
this and if so, is this implementation sufficient for their purposes?
