Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUJ3Ppu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUJ3Ppu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUJ3PjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:39:00 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:29701 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261209AbUJ3PQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:16:37 -0400
Date: Sat, 30 Oct 2004 16:16:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>,
       Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Message-ID: <20041030151623.GA25796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>,
	Sylvain Meyer <sylvain.meyer@worldonline.fr>,
	Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20041029014930.21ed5b9a.akpm@osdl.org> <20041030032425.GI6677@stusta.de> <1099124920.2822.3.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099124920.2822.3.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 10:28:41AM +0200, Arjan van de Ven wrote:
> 
> > The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with 
> > code adding usage of them in Linus' tree:
> 
> that makes me really really curious why the fb driver calls into the backend and not just the agp frontend layer like the rest of the world does...

In agpgart context the "fronend" is the character device for userland.
these functions should be exported because they are the driver API.  The
only reason they weren't used previously is because of the inter_module_*
braindamage to hide it.

