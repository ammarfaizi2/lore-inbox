Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUHDWzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUHDWzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUHDWzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:55:23 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:26050 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267491AbUHDWzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:55:21 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg Howard <ghoward@sgi.com>
Subject: Re: [PATCH] [2.6.8-rc2-mm2] More Altix system controller changes
Date: Wed, 4 Aug 2004 15:53:42 -0700
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
References: <Pine.SGI.4.58.0408031041220.10767@gallifrey.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.58.0408031041220.10767@gallifrey.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041553.42689.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 9:02 am, Greg Howard wrote:
>  config SGI_SNSC
>  	bool "SGI Altix system controller communication support"
> -	depends on CONFIG_IA64_SGI_SN2
> +	depends on IA64_SGI_SN2

This should be

-	depends on CONFIG_IA64_SGI_SN2
+	depends on (IA64_SGI_SN2 || IA64_GENERIC)

instead, since we'll want the driver in generic kernels too (IA64_SGI_SN2 
won't be set if IA64_GENERIC is set).

Thanks,
Jesse
