Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUCCKTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCCKTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:19:53 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:11788 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262389AbUCCKTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:19:49 -0500
Date: Wed, 3 Mar 2004 07:18:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: James Morris <jmorris@redhat.com>
cc: Glen Nakamura <glen@imodulo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Mysterious string truncation in 2.4.25 kernel
In-Reply-To: <Xine.LNX.4.44.0403030043380.32045-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0403030712570.2537-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Mar 2004, James Morris wrote:

> On Tue, 2 Mar 2004, Glen Nakamura wrote:
> 
> > Of course, perhaps 0 should passed instead of "" for data_page?
> > 
> > -    err = do_mount ("none", "/dev", "devfs", 0, "");
> > +    err = do_mount ("none", "/dev", "devfs", 0, 0);
> >
> > Comments?
> 
> Yes, the devfs fix above is needed if the data_page patch has been 
> applied.  
> 
> This is the case in 2.6, but not 2.4.25.

My bad :(

Changed last argument of fs/devfs/base.c do_mount() call to NULL, as per 
2.6.

James, wonder if your change can't cause other similar problems in 2.4? 

