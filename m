Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTKKPDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbTKKPDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:03:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:65417
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263539AbTKKPDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:03:10 -0500
Date: Tue, 11 Nov 2003 16:02:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031111150242.GE1649@x30.random>
References: <fa.na6uip6.p2erhm@ifi.uio.no> <fa.dbkbts9.1k7ohhd@ifi.uio.no> <3FB05EDE.6090007@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB05EDE.6090007@myrealbox.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:00:30PM -0800, walt wrote:
> Andrea Arcangeli wrote:
> 
> >>On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
> >The best way to fix this isn't to add locking to rsync, but to add two
> >files inside or outside the tree, each one is a sequence number, so you
> >fetch file1 first, then you rsync and you fetch file2, then you compare
> >them. If they're the same, your rsync copy is coherent. It's the same
> >locking we introduced with vgettimeofday...
> 
> How is this different from writing one file named LOCK while updating
> the tree?

it's very different, your file named LOCK can be created and deleted
while rsync was running, and rsync will never notice. rsync is readonly,
it'll never care about locks.
