Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWKEIWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWKEIWc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 03:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965856AbWKEIWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 03:22:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7122
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965854AbWKEIWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 03:22:31 -0500
Date: Sun, 05 Nov 2006 00:22:37 -0800 (PST)
Message-Id: <20061105.002237.18309940.davem@davemloft.net>
To: hch@lst.de
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061104235323.GA1353@lst.de>
References: <20061104225629.GA31437@lst.de>
	<20061104230648.GB640@redhat.com>
	<20061104235323.GA1353@lst.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sun, 5 Nov 2006 00:53:23 +0100

> On Sat, Nov 04, 2006 at 06:06:48PM -0500, Dave Jones wrote:
> > On Sat, Nov 04, 2006 at 11:56:29PM +0100, Christoph Hellwig wrote:
> > 
> > This will break the compile for !NUMA if someone ends up doing a bisect
> > and lands here as a bisect point.
> > 
> > You introduce this nice wrapper..
> 
> The dev_to_node wrapper is not enough as we can't assign to (-1) for
> the non-NUMA case.  So I added a second macro, set_dev_node for that.
> 
> The patch below compiles and works on numa and non-NUMA platforms.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.
