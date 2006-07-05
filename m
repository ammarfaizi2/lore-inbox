Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWGEXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWGEXsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWGEXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:48:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965074AbWGEXsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:48:22 -0400
Date: Wed, 5 Jul 2006 16:48:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: kmannth@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060705164820.379a69ba.akpm@osdl.org>
In-Reply-To: <20060705164457.60e6dbc2.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	<20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	<20060705164457.60e6dbc2.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 16:44:57 -0700
Andrew Morton <akpm@osdl.org> wrote:

> I guess a medium-term fix would be to add a boot parameter to override
> PERCPU_ENOUGH_ROOM - it's hard to justify increasing it permanently just
> for the benefit of the tiny minority of kernels which are hand-built with
> lots of drivers in vmlinux.
> 

That's not right, is it.  PERCPU_ENOUGH_ROOM covers vmlinux and all loaded
modules, so if vmlinux blows it all then `modprobe the-same-stuff' will
blow it as well.

> But first let's find out where it all went.

I agree with that person.
