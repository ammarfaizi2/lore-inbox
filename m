Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbTIDDcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTIDDck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:32:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17578 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264609AbTIDDa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:30:58 -0400
Date: Wed, 3 Sep 2003 20:21:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bunk@fs.tum.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] Re: 2.6.0-test4-mm5
Message-Id: <20030903202120.3671596a.davem@redhat.com>
In-Reply-To: <3F5617A9.4040603@pobox.com>
References: <20030902231812.03fae13f.akpm@osdl.org>
	<20030903161200.GC23729@fs.tum.de>
	<3F5617A9.4040603@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 12:32:41 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> David, would you look over this patch and apply/modify?

Applied, thanks Jeff.

> I would prefer to use the generic ethtool_op_get_link, because (a) 
> sungem is already using netif_carrier_xxx, and (b) if ->get_link ever 
> returns an incorrect value, that signals a netif_carrier_xxx bug exists.

Agreed.

> As a tangent, gem_pcs_interrupt appears to call netif_carrier_xxx but 
> not set gem->lstate.  David/Ben, is that a bug?

Doesn't really matter, I don't think the rest of the PCS code even
cares about the setting of gem-lstate.
