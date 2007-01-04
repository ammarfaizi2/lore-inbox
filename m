Return-Path: <linux-kernel-owner+w=401wt.eu-S1751114AbXADKQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXADKQn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 05:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXADKQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 05:16:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36065 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751114AbXADKQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 05:16:42 -0500
Date: Thu, 4 Jan 2007 10:27:02 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: ahendry <ahendry@tusc.com.au>
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.19 1/2] X.25: Adds call forwarding to X.25
Message-ID: <20070104102702.30630a9d@localhost.localdomain>
In-Reply-To: <1167881822.5124.88.camel@localhost>
References: <1167881822.5124.88.camel@localhost>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	struct sk_buff *skbn;
> +	skbn = skb_clone(skb, GFP_ATOMIC);
> +

If this fails then you starting passing NULL around. I'm also a bit
confused as to where you free the copy in all the error cases ?

Is there any reason for creating skbn here rather than in
skb_forward_call ?

