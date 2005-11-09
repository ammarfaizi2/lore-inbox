Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVKIOGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVKIOGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVKIOGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:06:14 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:2831 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750778AbVKIOGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:06:12 -0500
To: pmarques@grupopie.com
CC: jgarzik@pobox.com, axboe@suse.de, neilb@suse.de,
       linux-kernel@vger.kernel.org
In-reply-to: <E1EZpTU-0001KK-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Wed, 09 Nov 2005 13:54:48 +0100)
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com> <17265.42782.188870.907784@cse.unsw.edu.au> <4371A944.6070302@pobox.com> <20051109075455.GN3699@suse.de> <4371ACE6.7010503@pobox.com> <4371EEBA.2080706@grupopie.com> <E1EZpTU-0001KK-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EZqZK-0001RV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 15:04:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> That got me thinking... theoretically we should be able to do a FUSE 
> server that served a single file that could be used by a loopback 
> device, couldn't we?
> 
> IIRC, Miklos Szeredi tried hard to avoid the deadlock scenarios that nbd 
> suffers from in FUSE, but I don't know if it would stand being called by 
> the loopback device.

N.B. though FUSE itself is free of deadlocks, as soon as you put
something on top of it which has asyncronous page writeback it will
not be safe anymore.

So the issues with NBD will still be there if you loopback mount a
fuse file.

Miklos
