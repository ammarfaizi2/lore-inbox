Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTIOXM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTIOXMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:12:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4504 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261697AbTIOXLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:11:41 -0400
Date: Mon, 15 Sep 2003 15:59:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
Message-Id: <20030915155952.17767ca0.davem@redhat.com>
In-Reply-To: <3F644E36.5010402@colorfullife.com>
References: <3F644E36.5010402@colorfullife.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003 13:17:10 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> The attached patch adds likely to the tests - any objections? What about 
> the archs except i386?

On sparc64, access_ok() is a constant, so it doesn't matter
there.

Sparc32 probably should have it.
