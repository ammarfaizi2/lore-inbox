Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTHZWeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTHZWcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:32:17 -0400
Received: from 12-224-153-43.client.attbi.com ([12.224.153.43]:51766 "EHLO
	anholt.dyndns.org") by vger.kernel.org with ESMTP id S263022AbTHZW2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:28:33 -0400
Subject: RE: [Dri-devel] Re: 2.4.22-rc2 unresolved symbols in drm/sis.o wh
	en CONFIG_AGP=m
From: Eric Anholt <eta@lclark.edu>
To: Alexander Stohr <AlexanderS@ati.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Filip Sneppe <filip.sneppe@yucom.be>,
       faith@valinux.com, DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <328A30E823B7D511A0BF00065B042A3B0172D80D@fgl00exh01.fgl.atitech.com>
References: <328A30E823B7D511A0BF00065B042A3B0172D80D@fgl00exh01.fgl.atitech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061936842.23451.5.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 15:27:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-17 at 09:12, Alexander Stohr wrote:
> why wont the module compilation still pass
> when SIS fb configuration flags from the
> Linux kernel configuration are missing?
> 
> sorry if that requirement is already
> mentioned in the readme. i am just wondering.

The SiS DRM uses sisfb to allocate the framebuffer memory (XFree86 uses
sisfb, too, when present).  There is currently no fallback method for
when sisfb is not present.  I am working at the moment on removing this
requirement.  We could have ifdeffed appropriately and built a
non-functional module, but that wasn't done.

I hope nobody minds me making massive style changes on the sis DRM
code.  I find it quite ugly at the moment.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org

