Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVADPHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVADPHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVADPHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:07:32 -0500
Received: from quark.didntduck.org ([69.55.226.66]:6893 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261667AbVADPH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:07:26 -0500
Message-ID: <41DAB13E.40208@didntduck.org>
Date: Tue, 04 Jan 2005 10:07:42 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] AC97 plugin suspend/resume
References: <1104850247.9143.335.camel@cearnarfon>
In-Reply-To: <1104850247.9143.335.camel@cearnarfon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Girdwood wrote:
> This patch sets suspend and resume to NULL in the ad1980 plugin.
> 
> Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
> 
> Liam
> 
> 
> ------------------------------------------------------------------------
> 
> --- a/sound/oss/ac97_plugin_ad1980.c	2004-12-24 21:33:48.000000000 +0000
> +++ b/sound/oss/ac97_plugin_ad1980.c	2005-01-04 14:15:40.000000000 +0000
> @@ -89,6 +89,8 @@
>  	.name		= "AD1980 example",
>  	.probe		= ad1980_probe,
>  	.remove		= __devexit_p(ad1980_remove),
> +	.suspend	= NULL,
> +	.resume		= NULL,
>  };
>  
>  /**

There is really no reason to add these fields if they are NULL.  Zero 
(or NULL for pointers) is the default for all unspecified fields, and it 
is kernel convention to use this feature to reduce clutter.

--
				Brian Gerst
