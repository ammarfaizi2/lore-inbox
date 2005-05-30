Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVE3VaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVE3VaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVE3VaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:30:04 -0400
Received: from smtp04.auna.com ([62.81.186.14]:60402 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261559AbVE3V23 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:28:29 -0400
Date: Mon, 30 May 2005 21:28:27 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [RFT][PATCH] aic79xx: remove busyq
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050529074620.GA26151@havoc.gtf.org>
In-Reply-To: <20050529074620.GA26151@havoc.gtf.org> (from jgarzik@pobox.com
	on Sun May 29 09:46:20 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117488507l.7621l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.79] Login:jamagallon@able.es Fecha:Mon, 30 May 2005 23:28:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.29, Jeff Garzik wrote:
> 
> Can anyone with aic79xx hardware give me a simple "it works"
> or "this breaks things" answer, for the patch below?
> 
> This changes the aic79xx driver to use the standard Linux SCSI queueing
> code, rather than its own.  After applying this patch, NO behavior
> changes should be seen.
> 
> The patch is against 2.6.12-rc5, but probably applies OK to recent 2.6.x
> kernels.
> 

Applied with even no offsets to -rc5-mm1. Booted and working fine:

before

/dev/sda:
 Timing cached reads:   2744 MB in  2.00 seconds = 1370.15 MB/sec
 Timing buffered disk reads:  158 MB in  3.00 seconds =  52.64 MB/sec

after

/dev/sda:
 Timing cached reads:   3000 MB in  2.00 seconds = 1498.73 MB/sec
 Timing buffered disk reads:  160 MB in  3.03 seconds =  52.85 MB/sec

so no loose.

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


