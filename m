Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUGITPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUGITPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUGITPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:15:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:61662 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265396AbUGITPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:15:20 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Date: Fri, 9 Jul 2004 21:15:17 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Bastian Blank <bastian@waldi.eu.org>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org> <20040709120336.74e57ceb.akpm@osdl.org>
In-Reply-To: <20040709120336.74e57ceb.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407092115.18097.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bastian Blank <bastian@waldi.eu.org> wrote:
> >  The attached patch marks IPv6 support for QETH broken, it is known to
> >  need an extra patch to compile which was submitted one year ago but
> >  never accepted.
>
> Well fixing it would be the preferable approach.  Where is the "extra
> patch" and what was the complaint?

http://oss.sgi.com/projects/netdev/archive/2003-02/msg00061.html

The problem is that on s390 several virtual servers share the PHY and MAC 
part of the card and therefore have the same MAC address. Unfortunately 
IPv6 uses this MAC address to build an address. Now all virtual servers 
have the same auto configured IPv6 address - which is bad.
The proposed solution was to enable network card drivers to define their own 
ipv6 address auto configuration. 
If I recall correctly Dave Miller was not sure about rfc compliance. 

cheers

Christian




