Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUAAIQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 03:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUAAIQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 03:16:39 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:17524 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id S265350AbUAAIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 03:16:38 -0500
Date: Thu, 1 Jan 2004 19:19:03 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Paul Jakma <paul@clubi.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
In-Reply-To: <Pine.LNX.4.56.0312291719160.16956@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.05.10401011905310.31562-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Paul Jakma wrote:

[...]
> > Is chmod of an in-use swapfile an important thing to be able to do?
> 
> Had a box under memory pressure and had to add a swapfile to relieve
> said pressure. Noticed afterwards that it had been created under
> umask 0022 - not good, and the chmod to remove read rights for all 
> blocked. Thankfully, it was my desktop, not a multiple user server :)
[...]

How much of the original problem goes away if swapon(8) were to refuse to
activate a file/device which has ownership/mode which it doesn't like?

Of course such a change to swapon(8) should be accompanied by a flag to
force swapping on a file/device with non-sane ownership/mode.

Regards,
Neale.

