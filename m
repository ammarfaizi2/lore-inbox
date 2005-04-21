Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVDUKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVDUKsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDUKsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:48:11 -0400
Received: from [81.2.110.250] ([81.2.110.250]:22415 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261274AbVDUKsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 06:48:08 -0400
Subject: Re: [PATCH] hpt366: HPT372N rev 2 controller fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Lee <trisk@jhu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504210154.20031.trisk@jhu.edu>
References: <200504210154.20031.trisk@jhu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114076839.7656.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Apr 2005 10:47:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-21 at 06:54, Albert Lee wrote:
> A particular revision of the HPT372N oopses hpt366 consistently. It's a 
> regression caused by Alan's changes in 2.6.9 to support the HPT372N using 
> only PLL timings. The driver works correctly in prior versions, where the the 
> PCI clock is used instead. This patch restores that behaviour for this 
> particular revision.

For some drives, if you are lucky. The problem is that the PLL code in
the hpt366 driver is simply wrong. The -ac tree has some cleanup work in
this area but hasn't fixed the PLL code yet. The vendor driver does
handle this chip correctly.

Linus please avoid this patch - better an oops than disk corruption.

Alan

