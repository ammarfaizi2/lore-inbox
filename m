Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTKLAB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTKLAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:01:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1516 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263837AbTKLAB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:01:27 -0500
Date: Tue, 11 Nov 2003 15:55:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jhf@rivenstone.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [OOPS] TLAN fails on ifconfig with CONFIG_HOTPLUG=n
Message-Id: <20031111155518.52db3e71.davem@redhat.com>
In-Reply-To: <20031111153013.3b9eba6e.akpm@osdl.org>
References: <20031111222933.GA2868@rivenstone.net>
	<20031111153013.3b9eba6e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 15:30:13 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Does this fix it?
 ...
> -} board_info[] __devinitdata = {
> +} board_info[] = {

This fix is needed, definitely.  Even if it doesn't cure this
specific bug.

I'll merge this into my networking tree and push to Linus.

Thanks Andrew.
