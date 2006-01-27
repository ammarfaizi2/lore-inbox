Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWA0NQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWA0NQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWA0NQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:16:08 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:29451 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750787AbWA0NQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:16:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Jks7CmcqjWrKc2NgQd+Fv2wXD5PCJqSQQ6VlHQtmfjRHWCSi6VK48Hj5rCxpwbE5LNsZZKXysuGls2mPvZEmkfXJpbbmLPfgDL1IKMeGiPx+zF1AHzOq0CkntQVbWxuEHTFzYPBkvrFQzLkMKVnVsjLwaVJmyS5AYl75EsZTRaI=
Date: Fri, 27 Jan 2006 16:33:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, axboe@suse.de, askernel2615@dsgml.com,
       jamie@audible.transient.net, neilb@suse.de
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
Message-ID: <20060127133354.GA11011@mipter.zuzino.mipt.ru>
References: <200601270410.06762.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601270410.06762.chase.venters@clientec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 04:09:44AM -0600, Chase Venters wrote:
> 	All bisect kernels were built from the same .config, and "make clean; make
> mrproper" was executed between each compile. (Do I really need to do that?

	git bisect {good,bad}
	make

should be enough.

First bisect steps usually result in full rebuild because some often
included header is patched.

> How does git handle timestamps? I assumed I didn't really need to but did it
> to be thorough).

