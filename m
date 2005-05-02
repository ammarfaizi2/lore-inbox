Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVEBRb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVEBRb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEBQ1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:27:19 -0400
Received: from colin.muc.de ([193.149.48.1]:8966 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261370AbVEBQKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:10:30 -0400
Date: 2 May 2005 18:10:29 +0200
Date: Mon, 2 May 2005 18:10:29 +0200
From: Andi Kleen <ak@muc.de>
To: "Guo, Racing" <racing.guo@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, "Yu, Luming" <luming.yu@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-ID: <20050502161029.GF27150@muc.de>
References: <16A54BF5D6E14E4D916CE26C9AD305750162F6F1@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305750162F6F1@pdsmsx402.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:01:53AM +0800, Guo, Racing wrote:
> >
> >If Luming would not move the mce.c file from x86-64 to i386 then
> >his patch would be only 1/4 as big. I dont know why he does this
> >anyways, it seems completely pointless.
> 
> mce.c mce.h and mce_intel.c are moved from x86_64 to i386. so the
> patch is very big. The motivation is to share mce code between
> x86_64 and i386 and avoid duplicate code in x86_64 and i386.
> I don't know whether I completely understand what you point.
> Correct me if I am wrong.

You can share code as well by linking it from x86-64 into i386,
not only the other way round.  This is already done for earlyprintk
for example.

-Andi


