Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWBTVju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWBTVju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWBTVju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:39:50 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:53706 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S932618AbWBTVjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:39:49 -0500
Message-ID: <43FA3706.5080401@nortel.com>
Date: Mon, 20 Feb 2006 15:39:18 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove ccache from top level Makefile and make configurable
References: <43F9B8A9.4000506@reub.net> <20060220193616.GA16407@shadowen.org>
In-Reply-To: <20060220193616.GA16407@shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2006 21:39:22.0000 (UTC) FILETIME=[1C89E100:01C63666]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> remove ccache from top level Makefile and make configurable

Isn't it already configurable?


> diff -upN reference/Makefile current/Makefile
> --- reference/Makefile
> +++ current/Makefile
> @@ -171,9 +171,11 @@ SUBARCH := $(shell uname -m | sed -e s/i
>  # Alternatively CROSS_COMPILE can be set in the environment.
>  # Default value for CROSS_COMPILE is not to prefix executables
>  # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
> +# CCACHE specifies the name of a ccache binary to use with gcc.
>  
>  ARCH		?= $(SUBARCH)
>  CROSS_COMPILE	?=
> +CCACHE		?=

This sets it to nothing if it isn't already set--seems like you should 
be able to set it on the commandline or else it has no effect.

Chris
