Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVCCS31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCCS31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCCS1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:27:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6039 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261241AbVCCS0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:26:55 -0500
Message-ID: <422756DC.6000405@pobox.com>
Date: Thu, 03 Mar 2005 13:26:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Rebe <rene@exactcode.de>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422751D9.2060603@exactcode.de>
In-Reply-To: <422751D9.2060603@exactcode.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe wrote:
> Hi,
> 
> 
> --- linux-2.6.11/drivers/md/raid6altivec.uc.vanilla    2005-03-02 
> 16:44:56.407107752 +0100
> +++ linux-2.6.11/drivers/md/raid6altivec.uc    2005-03-02 
> 16:45:22.424152560 +0100
> @@ -108,7 +108,7 @@
>  int raid6_have_altivec(void)
>  {
>      /* This assumes either all CPUs have Altivec or none does */
> -    return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
> +    return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;


I nominate this as a candidate for linux-2.6.11 release branch.  :)

	Jeff


