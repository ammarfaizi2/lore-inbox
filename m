Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVLEBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVLEBea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLEBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 20:34:30 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:57295 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751321AbVLEBe3 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 4 Dec 2005 20:34:29 -0500
Date: Mon, 5 Dec 2005 09:48:42 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051205014842.GA5103@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nikita Danilov <nikita@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <20051203071444.260068000@localhost.localdomain> <20051203071609.755741000@localhost.localdomain> <17298.56560.78408.693927@gargle.gargle.HOWL> <20051204134818.GA4305@mail.ustc.edu.cn> <17299.1331.368159.374754@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17299.1331.368159.374754@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 06:03:15PM +0300, Nikita Danilov wrote:
>  > inter-reference distance, and therefore should be better protected(if ignore
>  > possible read-ahead effects). If we move re-accessed pages immediately into
>  > active_list, we are pushing them closer to danger of eviction.
> 
> Huh? Pages in the active list are closer to the eviction? If it is
> really so, then CLOCK-pro hijacks the meaning of active list in a very
> unintuitive way. In the current MM active list is supposed to contain
> hot pages that will be evicted last.

The page is going to active list anyway. So its remaining lifetime in inactive
list is killed by the early move.

Thanks,
Wu
