Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWCUWZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWCUWZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWCUWZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:25:30 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:30311 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750713AbWCUWZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:25:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LyPcPOeBXIBJXEbibybv8LNRvS30iixhkT7bN+dwaCKUClFQEddNzElUxGp7PNdyj2NwaBTf5H8S5oCoSGmWiCEMz2pFmoU4JW6DpPciAg+pKi/WiKCGDR90In1DN1V1KxvJSkMypXnlLfx4u+xkLWva/ouFw/zBoCiCXJcRzO0=
Message-ID: <44207D53.3010302@gmail.com>
Date: Wed, 22 Mar 2006 02:25:23 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mchehab@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix dvb build
References: <20060321221949.GA24322@havoc.gtf.org>
In-Reply-To: <20060321221949.GA24322@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

Jeff Garzik wrote:
> Fixes 'allmodconfig' build in current git
> (ec1248e70edc5cf7b485efcc7b41e44e10f422e5).
>
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
>
> diff --git a/drivers/media/dvb/bt8xx/Makefile b/drivers/media/dvb/bt8xx/Makefile
> index 9d197ef..d188e4c 100644
> --- a/drivers/media/dvb/bt8xx/Makefile
> +++ b/drivers/media/dvb/bt8xx/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o dst_ca.o
>  
> -EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video/bt8xx -Idrivers/media/dvb/frontends
> +EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video -Idrivers/media/dvb/frontends
>
>   

The relocation patch is there in akpm's (mm) tree, but not in linus's 
tree .. importing the patch from the mm tree will fix the problem.


Manu


