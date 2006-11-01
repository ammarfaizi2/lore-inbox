Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423870AbWKAAxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423870AbWKAAxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423871AbWKAAxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:53:17 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55429
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423870AbWKAAxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:53:17 -0500
Date: Tue, 31 Oct 2006 16:53:14 -0800 (PST)
Message-Id: <20061031.165314.39158827.davem@davemloft.net>
To: clameter@sgi.com
Cc: hch@lst.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610311610150.7609@schroedinger.engr.sgi.com>
References: <20061030141501.GC7164@lst.de>
	<20061030.143357.130208425.davem@davemloft.net>
	<Pine.LNX.4.64.0610311610150.7609@schroedinger.engr.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <clameter@sgi.com>
Date: Tue, 31 Oct 2006 16:10:48 -0800 (PST)

> On Mon, 30 Oct 2006, David Miller wrote:
> 
> > So, please add some sanity to this situation and just put the node
> > into the generic struct device. :-)
> 
> Good. Then we can remove the node from the pci structure and get rid of 
> pcibus_to_node?

Yes, that's possible, because the idea is that the arch specific
bus layer code would initialize the node value.  Therefore, there
would be no need for things like pcibus_to_node() any longer.

