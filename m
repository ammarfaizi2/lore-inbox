Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263701AbUJ3LXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUJ3LXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263699AbUJ3LXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:23:10 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:6851 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S263697AbUJ3LWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:22:55 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Date: Sat, 30 Oct 2004 19:21:31 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>,
       Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
References: <20041029014930.21ed5b9a.akpm@osdl.org> <20041030032425.GI6677@stusta.de> <1099124920.2822.3.camel@laptop.fenrus.org>
In-Reply-To: <1099124920.2822.3.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410301921.34961.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 16:28, Arjan van de Ven wrote:
> > The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with
> > code adding usage of them in Linus' tree:
>
> that makes me really really curious why the fb driver calls into the
> backend and not just the agp frontend layer like the rest of the world
> does...
>

Because all functions in the frontend are marked static and are accessible
only via ioctl.

Anyway, I think the drivers can make do without the
agp_backend_acquire/release() functions, since all they do is
increment/decrement  a use count field.  I don't know about agp_copy_info()
but it might be possible to get the agp information from pci_dev structure.
This part I'm not sure.

What's wrong with exporting the symbols back again?

Tony


