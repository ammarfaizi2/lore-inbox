Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031158AbWK3Sp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031158AbWK3Sp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 13:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031172AbWK3Sp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 13:45:58 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:57726 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1031158AbWK3Sp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 13:45:58 -0500
Date: Thu, 30 Nov 2006 10:45:56 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Adrian Bunk <bunk@stusta.de>, David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup() static
Message-ID: <20061130184556.GA23293@hexapodia.org>
References: <20061125191541.GH3702@stusta.de> <1164752386.14595.24.camel@pmac.infradead.org> <20061125191541.GH3702@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164752386.14595.24.camel@pmac.infradead.org> <20061125191541.GH3702@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 08:15:41PM +0100, Adrian Bunk wrote:
> This patch makes the needlessly global mtdpart_setup() static.
> 
> @@ -346,7 +346,7 @@
>   *
>   * This function needs to be visible for bootloaders.
>   */
> -int mtdpart_setup(char *s)
> +static int mtdpart_setup(char *s)
>  {
>  	cmdline = s;
>  	return 1;

Jarkko,

You're recorded as submitting the original patch to make this
non-static:
http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/mtd/cmdlinepart.c@1.11?nav=index.html|src/|src/drivers|src/drivers/mtd|hist/drivers/mtd/cmdlinepart.c

Is this change correct?

If so, it should also delete the "needs to be visible" comment.

-andy
