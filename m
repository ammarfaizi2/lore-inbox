Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVF0VSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVF0VSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVF0VQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:16:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261759AbVF0VOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:14:06 -0400
Date: Mon, 27 Jun 2005 14:14:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Message-Id: <20050627141439.4b3cb641.akpm@osdl.org>
In-Reply-To: <20050627093708.GA23150@elte.hu>
References: <fa.h6rvsi4.j68fhk@ifi.uio.no>
	<42BFA05B.1090208@reub.net>
	<20050627002429.40231fdf.akpm@osdl.org>
	<42BFAF1F.8050201@reub.net>
	<20050627012226.450bc86d.akpm@osdl.org>
	<20050627093708.GA23150@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> is the fput()/sysfs_release() crash below known?

It doesn't ring any bells.

You have a use-after-free error when udev is dinking with a sysfs file.  It
could be anything.  Could you debug it a bit, please, work out which file
caused the crash?
