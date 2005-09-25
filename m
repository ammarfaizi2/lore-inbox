Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbVIYXpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbVIYXpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 19:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbVIYXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 19:45:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751555AbVIYXpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 19:45:11 -0400
Date: Sun, 25 Sep 2005 16:44:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: linux-kernel@vger.kernel.org, ccalica@gmail.com,
       xorg@lists.freedesktop.org
Subject: Re: 2.6.14-rc2-mm1
Message-Id: <20050925164421.75c734d2.akpm@osdl.org>
In-Reply-To: <20050925220037.GA8776@blazebox.homeip.net>
References: <20050925220037.GA8776@blazebox.homeip.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Blazejowski <paulb@blazebox.homeip.net> wrote:
>
>  Upon quick testing the latest mm kernel it appears there's some kind of
>  race condition when using dual core cpu esp when using XORG and USB
>  (although PS2 has same issue) kebyboard rate being too fast.
> 
>  The same behaviour happens on vanilla 2.6.13 kernel. Reporting this also
>  to XORG list in hopes to help debug this issue.

Is it possible to narrow this down a bit further?  Was 2.6.12 OK?

If we can identify two reasonably-close-in-time versions either side of the
regression then the next step would be to run `dmesg -s 1000000' under both
kernel versions, then run `diff -u dmesg.good dmesg.bad'.

