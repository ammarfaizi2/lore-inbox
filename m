Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUIMMcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUIMMcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUIMMcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:32:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17593 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266613AbUIMMcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:32:36 -0400
Subject: Re: graphics futures - untoasted..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409131224590.5648@skynet>
References: <Pine.LNX.4.58.0409131224590.5648@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095074987.14359.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 12:29:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 13:10, Dave Airlie wrote:
> So what are peoples view on doing the following to the radeon driver after
> Alan has showed the code...

I've not had time to test it but I just posted the code as-is since
thats probably the best way right now

> Now I know someone might say that we probably don't need a common layer,
> that with Alans scheme the fb can call the drm and the drm the fb, but if
> this happens then you start mandating the fb be loaded for certain DRM
> things and vice-versa,

Agreed - it will depend on the card, and on what makes sense for other
reasons. Memory manager code may also need to be part of that. The code
I posted has no provision for "common" module, but just add it to the
list and it'll hopefully DTRT. Providing the DRI and FB drivers
reference symbols in the common module it'll also autoload properly.

Let me know what you think of the code so far (however bad) and I'll try
and get it ticking nicely.

