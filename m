Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWG3TGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWG3TGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWG3TGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:06:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWG3TGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:06:37 -0400
Date: Sun, 30 Jul 2006 12:06:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Message-Id: <20060730120631.9ee1ab09.akpm@osdl.org>
In-Reply-To: <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
References: <200607301830.01659.jesper.juhl@gmail.com>
	<200607301835.35053.jesper.juhl@gmail.com>
	<20060730113416.7c1d8f80.pj@sgi.com>
	<9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 20:48:23 +0200
"Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> > Perhaps I am misreading this patch set?
> >
> i don't think you are. It's just that I want to take the least
> intrusive route *now*, make us -Wshadow clean, get -Wshadow to be an
> accepted part of the Makefile, *then* deal with the more
> intrusive/controversial renamings, where I guess you'd have done
> things in the opposite order - right?

yup.  Experience tells us that it's better to get things right first time,
because we don't get around to doing the intended second pass (looks at
lock_cpu_hotplug())

That being said, no, we can't go and rename up().  Let us go through the
patches one-at-a-time..
