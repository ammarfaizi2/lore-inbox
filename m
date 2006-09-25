Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWIYOyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWIYOyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWIYOyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:54:32 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:6013 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750832AbWIYOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:54:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAABaIF0WLcgEBDQ
X-IronPort-AV: i="4.09,215,1157320800"; 
   d="scan'208"; a="3476630:sNHT30540336"
Date: Mon, 25 Sep 2006 16:54:29 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/03] net/bridge: add support for EtherIP devices
Message-ID: <20060925145429.GF23028@zlug.org>
References: <20060923120704.GA32284@zlug.org> <20060923121629.GC32284@zlug.org> <20060923210112.130938ca@localhost.localdomain> <20060925082445.GB23028@zlug.org> <20060925074009.781a2228@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925074009.781a2228@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 07:40:09AM -0700, Stephen Hemminger wrote:
> 
> To get a list of all EtherIP devices, just maintain a linked list
> in the private device information. Use list macros, it isn't hard.

I use lists in the driver to maintain the list. The problem is to get
such a list in userspace in a safe way (the way over SIOCDEVPRIVATE
ioctls is not safe).
