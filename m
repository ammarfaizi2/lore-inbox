Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937785AbWLGAGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937785AbWLGAGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937824AbWLGAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:06:32 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:34274 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937785AbWLGAGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:06:32 -0500
Date: Wed, 6 Dec 2006 16:03:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [DLM] Fix DLM config [46/70]
Message-Id: <20061206160342.494a3621.randy.dunlap@oracle.com>
In-Reply-To: <1164889242.3752.397.camel@quoit.chygwyn.com>
References: <1164889242.3752.397.camel@quoit.chygwyn.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 12:20:42 +0000 Steven Whitehouse wrote:

> >From b98c95af01c10827e3443157651eb469071391a3 Mon Sep 17 00:00:00 2001
> From: Patrick Caulfield <pcaulfie@redhat.com>
> Date: Wed, 15 Nov 2006 12:29:24 -0500
> Subject: [PATCH] [DLM] Fix DLM config
> 
> The attached patch fixes the DLM config so that it selects the chosen network
> transport. It should fix the bug where DLM can be left selected when NET gets
> unselected. This incorporates all the comments received about this patch.
> 
> ---
>  fs/dlm/Kconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
> index c5985b8..b5654a2 100644
> --- a/fs/dlm/Kconfig
> +++ b/fs/dlm/Kconfig
> @@ -1,10 +1,11 @@
>  menu "Distributed Lock Manager"
> -	depends on INET && IP_SCTP && EXPERIMENTAL
> +	depends on EXPERIMENTAL && INET
>  
>  config DLM
>  	tristate "Distributed Lock Manager (DLM)"
>  	depends on IPV6 || IPV6=n

What does that "depends on" (above) mean???

>  	select CONFIGFS_FS
> +	select IP_SCTP if DLM_SCTP
>  	help
>  	A general purpose distributed lock manager for kernel or userspace
>  	applications.
> -- 

Thanks.
---
~Randy
