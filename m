Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUIGQhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUIGQhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUIGQhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:37:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268248AbUIGQgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:36:12 -0400
Date: Tue, 7 Sep 2004 12:36:03 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <michal@logix.cz>
cc: Andreas Happe <andreashappe@flatline.ath.cx>, <cryptoapi@lists.logix.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
Message-ID: <Xine.LNX.4.44.0409071232590.26033-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004, Michal Ludvig wrote:

> I'd prefer to have the algorithms grouped by "type" ("cipher", "digest",
> "compress")? Then the apps could easily see only the algos that thay are
> interested in...

This could be done with symlinks.  Have a master algorithim directory, and 
symlinks to different views (e.g. 'ciphers').

> Few notes:
> - - some algorithms allow only discrete set of keysizes (e.g. AES can do
> 128b, 192b and 256b). Can we instead of min/max have a file 'keysize' with
> either:
> 	minsize-maxsize
> or
> 	size1,size2,size3
> ?
> 
> - - ditto for blocksize?

I don't think it's worth complicating the kernel code just to see that AES 
does in fact have the three key sizes required by the specification.


- James
-- 
James Morris
<jmorris@redhat.com>


