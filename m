Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTJCJD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 05:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTJCJD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 05:03:29 -0400
Received: from rth.ninka.net ([216.101.162.244]:12687 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263627AbTJCJD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 05:03:28 -0400
Date: Fri, 3 Oct 2003 02:03:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: Michal Kochanowicz <michal@michal.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test6] definition and usage of __u64/__s64 inconsistent?
Message-Id: <20031003020317.4d582970.davem@redhat.com>
In-Reply-To: <20031003085412.GA4602@wieszak.lan>
References: <20031003085412.GA4602@wieszak.lan>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003 10:54:12 +0200
Michal Kochanowicz <michal@michal.waw.pl> wrote:

> The file asm/types.h is _unconditionally_ included from linux/cdrom.h
> and linux/loop.h and both files use __u64 unonditionally. Isn't this an
> error?

Not really.

We could fix this by using the __extension__ keyword and thereby
get rid of the __STRICT_ANSI__ check and situations like your's
would work.
