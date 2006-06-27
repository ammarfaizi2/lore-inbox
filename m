Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWF0Nsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWF0Nsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWF0Nss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:48:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6845 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932279AbWF0Nsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:48:47 -0400
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup()
	static
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       juha.yrjola@solidboot.com
In-Reply-To: <20060626220215.GI23314@stusta.de>
References: <20060626220215.GI23314@stusta.de>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 14:49:00 +0100
Message-Id: <1151416141.17609.140.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 00:02 +0200, Adrian Bunk wrote:
> This patch makes the needlessly global mtdpart_setup() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c.old 2006-06-26 23:18:39.000000000 +0200
> +++ linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c     2006-06-26 23:18:51.000000000 +0200
> @@ -346,7 +346,7 @@
>   *
>   * This function needs to be visible for bootloaders.
>   */
> -int mtdpart_setup(char *s)
> +static int mtdpart_setup(char *s) 

Patch lacks sufficient explanation. Explain the relevance of the comment
immediately above the function declaration, in the context of your
patch. Explain your decision to change the behaviour, but not change the
comment itself.

Think. Or you will be replaced with a small shell script.

-- 
dwmw2

