Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVDNW4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDNW4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVDNW4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:56:49 -0400
Received: from coderock.org ([193.77.147.115]:19337 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261626AbVDNW4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:56:41 -0400
Date: Fri, 15 Apr 2005 00:56:35 +0200
From: Domen Puncer <domen@coderock.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/1] nbd: Don't create all MAX_NBD devices by default all the time
Message-ID: <20050414225635.GA3983@nd47.coderock.org>
References: <20050414112318.GL32354@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414112318.GL32354@marowsky-bree.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/05 13:23 +0200, Lars Marowsky-Bree wrote:
> From: Lars Marowsky-Bree <lmb@suse.de>
> 
> This patches adds the "nbds_max" parameter to the nbd kernel module,
> which limits the number of nbds allocated. Previously, always all 128
> entries were allocated unconditionally, which used to waste resources
> and needlessly flood the hotplug system with events. (Defaults to 16
> now.)
> 
...
>  
> +module_param(nbds_max, int, 16);

This is permissions in sysfs (or 0 if no file is to be created).

> +MODULE_PARM_DESC(nbds_max, "How many network block devices to initialize.");
>  #ifndef NDEBUG
>  module_param(debugflags, int, 0644);
>  MODULE_PARM_DESC(debugflags, "flags for controlling debug output");
