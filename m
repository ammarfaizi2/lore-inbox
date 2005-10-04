Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVJDRNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVJDRNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVJDRNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:13:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:58798 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964858AbVJDRNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:13:14 -0400
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [NUMA , x86_64] Why memnode_shift is chosen with the lowest possible value ?
Date: Tue, 4 Oct 2005 19:13:25 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <1127939141.26401.32.camel@localhost.localdomain> <433C1D6F.1030605@cosmosbay.com> <433D00BC.2070001@cosmosbay.com>
In-Reply-To: <433D00BC.2070001@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510041913.26332.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2005 11:09, Eric Dumazet wrote:
> +       while (populate_memnodemap(nodes, numnodes, shift + 1) >= 0)
> +               shift++;


Why shift+1 here? 


>+               if ((end >> shift) >= NODEMAPSIZE)
>+                       return 0;

This should be >, not >= shouldn't it?

-Andi

P.S.: Please cc x86-64 patches to discuss@x86-64.org
