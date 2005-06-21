Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFUL3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFUL3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFUL3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:29:41 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:44929 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261239AbVFULUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:20:03 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 21 Jun 2005 13:14:05 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vesafb to build when no CONFIG_MTRR
Message-ID: <20050621111404.GA16586@bytesex>
References: <42B802F2020000780001CEAB@lyle.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B802F2020000780001CEAB@lyle.provo.novell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_MTRR
>  	if (mtrr) {
> -		int temp_size = size_total;
> +		unsigned int temp_size = size_total;
>  		/* Find the largest power-of-two */
>  		while (temp_size & (temp_size - 1))
>                  	temp_size &= (temp_size - 1);
> @@ -396,6 +401,7 @@ static int __init vesafb_probe(struct de
>  			temp_size >>= 1;
>  		}
>  	}
> +#endif

I'd just do that to avoid cluttering up the source with
#ifdef's, otherwise it looks ok to me ;)

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
