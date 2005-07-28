Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVG1HtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVG1HtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVG1Hs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:48:56 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:33706 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S261345AbVG1Hsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:48:46 -0400
Date: Thu, 28 Jul 2005 16:44:18 +0900 (JST)
Message-Id: <20050728.164418.59468314.kaminaga@sm.sony.co.jp>
To: ben-linux@fluff.org
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       kaminaga@sm.sony.co.jp
Subject: Re: [PATCH][RFC] swsusp for OSK
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
In-Reply-To: <20050708150337.GB16299@home.fluff.org>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<20050708.212501.58462280.kaminaga@sm.sony.co.jp>
	<20050708150337.GB16299@home.fluff.org>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Fri, 8 Jul 2005 16:03:37 +0100

> Hmm, I have no idea if this is correct... I assume it is not saving
> the page tables over suspend/resume, and that is why you are having
> trouble restoring the page table? 

I looked more into swapper_pg_dir, and found that on i386, it was 4K
but on ARM, it was 16K.

The remaining 12K of swapper_pg_dir might not be saved across
suspend/resume, and this could be the cause of panic on resume on bigger
image.


HK.
--
