Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbTL3WwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbTL3WvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:51:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265892AbTL3Wur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:50:47 -0500
Date: Tue, 30 Dec 2003 14:46:08 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] clean up tcp_sk(), 2.6.0
Message-Id: <20031230144608.4c7e66f2.davem@redhat.com>
In-Reply-To: <20031230163230.GA12553@elte.hu>
References: <20031230163230.GA12553@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 17:32:30 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> i recently wasted a few hours on a bug where i used "tcp_sk(sock)"
> instead of "tcp_sk(sock->sk)" - the former, while being blatantly
> incorrect, compiles just fine on 2.6.0. The patch below is equivalent to
> the define but is also type-safe. Compiles cleanly & boots fine on
> 2.6.0.

Applied, and I'll happily accept patches for udp_sk() and all
the other ones too :)
