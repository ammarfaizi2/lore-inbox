Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTFHQfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTFHQfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 12:35:41 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:39429 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262494AbTFHQfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 12:35:39 -0400
Date: Sun, 8 Jun 2003 17:49:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Gergely Madarasz <gorgo@itc.hu>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030608174908.A9377@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Gergely Madarasz <gorgo@itc.hu>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20030608144038.GF16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030608144038.GF16164@fs.tum.de>; from bunk@fs.tum.de on Sun, Jun 08, 2003 at 04:40:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 04:40:38PM +0200, Adrian Bunk wrote:
> >From drivers/net/wan/comx.c:
> 
> <--  snip  -->
> 
> ...
> #ifndef CONFIG_PROC_FS
> #error For now, COMX really needs the /proc filesystem
> #endif
> ...
> 
> <--  snip  -->
> 
> 
> The following patch add a dependency to Kconfig to avoid compile errors 
> with CONFIG_COMX and !CONFIG_PROC_FS:

Actually it still doesn't link with this because the procfs code in it
is utter crap and relies on a symbol proc_get_inode that isn't exported
since 2.3.  As no one cared for this driver over years I'd suggest just
removing it.

