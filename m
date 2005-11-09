Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKIMzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKIMzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKIMzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:55:43 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:28175 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750719AbVKIMzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:55:42 -0500
To: pmarques@grupopie.com
CC: jgarzik@pobox.com, axboe@suse.de, neilb@suse.de,
       linux-kernel@vger.kernel.org
In-reply-to: <4371EEBA.2080706@grupopie.com> (message from Paulo Marques on
	Wed, 09 Nov 2005 12:42:34 +0000)
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com> <17265.42782.188870.907784@cse.unsw.edu.au> <4371A944.6070302@pobox.com> <20051109075455.GN3699@suse.de> <4371ACE6.7010503@pobox.com> <4371EEBA.2080706@grupopie.com>
Message-Id: <E1EZpTU-0001KK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 13:54:48 +0100
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
> 
> If it works, it should be extremely simple to do the server. Just check 
> the FUSE hello world server example:
> 
> http://fuse.sourceforge.net/helloworld.html
> 
> I've CC'ed Miklos Szeredi to see if he can shed some light on the 
> loopback <-> FUSE combination...

Loopback works fine on FUSE filesystems (unless 'direct_io' mount
option is used).

Miklos
