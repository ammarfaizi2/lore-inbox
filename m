Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425091AbWLHHj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425091AbWLHHj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425092AbWLHHj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:39:59 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:51826 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425091AbWLHHj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:39:58 -0500
Date: Fri, 08 Dec 2006 08:40:03 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: vmlist_lock locking
In-reply-to: <a574553e0612072307v766c3742pd3b4c46fb4fd0470@mail.gmail.com>
To: kernel list <list.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <457916D3.7060008@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <a574553e0612072307v766c3742pd3b4c46fb4fd0470@mail.gmail.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel list a écrit :
> My understanding is that get_vm_area_node etc. can't be called in
> interrupt context because vmlist_lock is obtained with read_lock /
> write_lock. I am wondering if it makes sense to use read_lock_bh /
> write_lock_bh so that get_vm_area_node can be called in soft interrupt
> context. All the code executed when holding vmlist_lock is walking
> through the list, so it shouldn't change the behavior. If it does make
> sense, BUG_ON(in_interrupt()) can be changed to BUG_ON(in_irq()).

Maybe it is just me, but I like to know people names.
Or maybe your name really is kernel list ?

I wonder why a soft irq would want to lookup vm areas.
(since vmalloc() from soft irq is *really* forbiden)

Eric

