Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVCVWqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVCVWqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVCVWqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:46:47 -0500
Received: from mail.suse.de ([195.135.220.2]:21904 "EHLO mail.suse.de")
	by vger.kernel.org with ESMTP id S262106AbVCVWqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:46:23 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/cdrom/gscd.c: kill dead code
References: <20050322215505.GN1948@stusta.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I want you to organize my PASTRY trays...  my TEA-TINS are gleaming
 in
 formation like a ROW of DRUM MAJORETTES --
 please don't be FURIOUS with me --
Date: Tue, 22 Mar 2005 23:46:20 +0100
In-Reply-To: <20050322215505.GN1948@stusta.de> (Adrian Bunk's message of
 "Tue, 22 Mar 2005 22:55:05 +0100")
Message-ID: <jemzsvb8oz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch removes some obviously dead code found by the Coverity 
> checker.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.12-rc1-mm1-full/drivers/cdrom/gscd.c.old	2005-03-22 20:58:54.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/cdrom/gscd.c	2005-03-22 20:59:46.000000000 +0100
> @@ -694,12 +694,8 @@
>  		do {
>  			result = wait_drv_ready();
>  		} while (result != 6 || result == 0x0E);
>  
> -		if (result != 6) {
> -			cmd_end();
> -			return;
> -		}

I'd rather guess that (result != 6 || result == 0x0E) is borken, since
it's equivalent to (result != 6).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
