Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTHTSf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbTHTSf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:35:29 -0400
Received: from rth.ninka.net ([216.101.162.244]:2183 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262104AbTHTSf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:35:26 -0400
Date: Wed, 20 Aug 2003 11:35:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hannes.Reinecke@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Dumb question: BKL on reboot ?
Message-Id: <20030820113520.281fe8bb.davem@redhat.com>
In-Reply-To: <20030820112918.0f7ce4fe.akpm@osdl.org>
References: <3F434BD1.9050704@suse.de>
	<20030820112918.0f7ce4fe.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 11:29:18 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Where exactly does the rebooting CPU get stuck in machine_restart()?  If
> someone has done lock_kernel() with local interrupts disabled then yes,
> it'll deadlock.  But that's unlikely?  Confused.

In fact I think that's illegal and we should bug check
such a state.
