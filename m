Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUIWASA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUIWASA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUIWASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:18:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:33942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268120AbUIWAR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:17:59 -0400
Date: Wed, 22 Sep 2004 17:21:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: tty ldisc work version 4
Message-Id: <20040922172139.0d7a1dd3.akpm@osdl.org>
In-Reply-To: <20040922141821.GA27672@devserv.devel.redhat.com>
References: <20040922141821.GA27672@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:
>
> New features this time
> - Fix synclink layers - Paul Fulghum
> - Use tty_wakeup internally to tty_io
> - Add initial termios locking
> - Add ldisc hangup method for notification at hangup()
> - Fixed close to wait for running driver side events
> 
> The big changes this time are locking/ordering rules for termios changes. As
> well as various feature changes I've also begun commenting n_tty.c so we
> can start tackling the ldisc internal issues.

This gives me "init_dev but no ldisc" when initscripts start playing with
the USB keyboard.  The machine then stops.
