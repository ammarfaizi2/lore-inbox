Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWAGIAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWAGIAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAGIAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:00:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964771AbWAGIAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:00:41 -0500
Date: Sat, 7 Jan 2006 00:00:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [patch 4/4] Actually make the f_ops field const
Message-Id: <20060107000015.0574c842.akpm@osdl.org>
In-Reply-To: <1136584267.2940.101.camel@laptopd505.fenrus.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
	<1136584267.2940.101.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> Mark the f_ops members of inodes as const, as well as fix the ripple-through
>  this causes by places that copy this f_ops and then "do stuff" with it.
>  (some of the "do stuff" is quite unpleasant..)

Right now is the worst possible time in the kernel cycle to be raising
large many-file patches like this.  You need to either take a look at
what's coming in -mm or wait until all the git trees have merged up then do
the patch against -linus.

In this case there are mulitple new references to non-const file_operations
added to Linus's tree by alsa 48 hours ago.
