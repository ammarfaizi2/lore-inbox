Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUEXJf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUEXJf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 05:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbUEXJf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 05:35:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:51387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264165AbUEXJfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 05:35:24 -0400
Date: Mon, 24 May 2004 02:34:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
Message-Id: <20040524023453.7cf5ebc2.akpm@osdl.org>
In-Reply-To: <40B1BEAC.30500@jp.fujitsu.com>
References: <40B1BEAC.30500@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com> wrote:
>
> Therefore this feature cannot be used at the same time with oprofile
>  and NMI watchdog. This feature hands NMI interrupt over to oprofile
>  and NMI watchdog. So, when they have been activated, this feature
>  doesn't work even if it is activated.

An API was recently added to solve this.  See reserve_lapic_nmi() and
release_lapic_nmi().
