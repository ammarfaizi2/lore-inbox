Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTKZUFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTKZUFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:05:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50326 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264319AbTKZUFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:05:32 -0500
Date: Wed, 26 Nov 2003 12:04:56 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126120456.1a70d77d.davem@redhat.com>
In-Reply-To: <20031126200153.GG14383@mail.shareable.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<20031126200153.GG14383@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 20:01:53 +0000
Jamie Lokier <jamie@shareable.org> wrote:

> Do the timestamps need to be precise and accurately reflect the
> arrival time in the irq handler?

It would be a regression to make the timestamps less accurate
than those provided now.

> Or, for TCP timestamps,

The timestamps we are talking about are not used for TCP.

> Apart from TCP, precise timestamps are only used for packet capture,
> and it's easy to keep track globally of whether anyone has packet
> sockets open.

We have no knowledge of what an applications requirements are,
that is why we provide as accurate a timestamp as possible.

If we were writing this stuff for the first time now, sure we could
specify things however conveniently we like, but how this stuff behaves
is already well defined.
