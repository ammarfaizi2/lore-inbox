Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUHCS2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUHCS2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHCS2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:28:23 -0400
Received: from mail.convergence.de ([212.84.236.4]:55940 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S266790AbUHCS2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:28:21 -0400
Date: Tue, 3 Aug 2004 20:28:24 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: boolean typo in DVB
Message-ID: <20040803182824.GB2628@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20040803010055.GB12571@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803010055.GB12571@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The email addresses in the source files are out of date,
bug reports should go to linux-dvb-maintainer [at] linuxtv.org.)

Dave Jones wrote:
> This looks like what was intended here..
...
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- 1/drivers/media/dvb/dvb-core/dvb_demux.c~	2004-08-03 01:57:45.605369592 +0100
> +++ 2/drivers/media/dvb/dvb-core/dvb_demux.c	2004-08-03 01:57:58.979336440 +0100
> @@ -179,7 +179,7 @@
>  		neq |= f->maskandnotmode[i] & xor;
>  	}
>  
> -	if (f->doneq & !neq)
> +	if (f->doneq && !neq)
>  		return 0;
>  
>  	return feed->cb.sec (feed->feed.sec.secbuf, feed->feed.sec.seclen, 

Yes, you've spotted a bug. I'll correct this in linuxtv CVS.

Thanks a lot,
Johannes
