Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbSJIOJR>; Wed, 9 Oct 2002 10:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbSJIOJR>; Wed, 9 Oct 2002 10:09:17 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:4621 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S261776AbSJIOI7>; Wed, 9 Oct 2002 10:08:59 -0400
Date: Wed, 9 Oct 2002 16:14:35 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <3DA33250.FB61BAAE@digeo.com>
Message-ID: <Pine.LNX.4.44.0210091612160.26363-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Andrew Morton wrote:

> I'd say that if you were designing a new application which
> streams large amount of data then yes, you would design it
> to use O_DIRECT.  You would instantiate a separate IO worker
> thread and a message passing mechanism so that thread would
> pump your data for you, and would peform your readahead, etc.
> 
> If your filesystem supports O_DIRECT, of course.  Not all do.
> 
> The strength of O_STREAMING is that you can take an existing,
> working, megahuge application and make it play better with the
> VM by changing a single line of code.  No big redesign needed.

Such as perl:

sysopen(MYKERNEL, "/boot/vmlinuz", 04000000);

O_DIRECT support is another beast, IMHO.

.TM.

