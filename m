Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTE1Wmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTE1Wmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:42:52 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6776 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261352AbTE1Wmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:42:51 -0400
Date: Wed, 28 May 2003 15:53:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPs report
Message-Id: <20030528155342.45d1e437.akpm@digeo.com>
In-Reply-To: <20030528151620.GA21579@the-penguin.otak.com>
References: <20030528151620.GA21579@the-penguin.otak.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 22:56:07.0163 (UTC) FILETIME=[52C1BCB0:01C3256C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
>
> Hello all I have a oops report, happened overnight don't know why,
> other then it looks devfs related. 
> 
> ..
> kernel BUG at include/linux/list.h:140!

yes, sorry.  -mm has extra list_head debugging goodies, and they detect
bugs in devfs.

We're still hoping to do something radical with devfs but if that doesn't
happen then we'll need to plug this bug somehow.

If it's a problem then you can just delete the two BUG_ON's from
include/linux/list.h:list_del().

