Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVKNSiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVKNSiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVKNSiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:38:51 -0500
Received: from main.gmane.org ([80.91.229.2]:58496 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751228AbVKNSiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:38:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 13:29:54 -0500
Message-ID: <dlal2q$kdo$1@sea.gmane.org>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> reasons. The ndis wrapper people have known it is coming for a long
> time, and if it has a lot of users I'm sure someone in that community
> will take the time to make patches.

I believe I mentioned it before. ndiswrapper itself has been 4k stacks ready
for quite sometime. It is Windows drivers that need more than 4k stacks
(although Windows uses 12k stacks, I don't know of any Windows driver
requiring more than 8k stacks). One or two Windows drivers work with
ndiswrapper and 4k stacks, Broadcom for example.

If this 4k stack patch makes into mainstream, I am wondering what options,
other than maintaining a patch to back this patch, are available. The last
time this issue came up some people suggested pushing ndiswrapper into user
space. However, AFAIK this is non-trivial; I looked into FUSD
http://www.circlemud.org/~jelson/software/fusd/ which doesn't support
network drivers and seems to be not active in the recent past.

Any suggestions on how ndiswrapper can live with this patch would be greatly
appreciated.

Giri

