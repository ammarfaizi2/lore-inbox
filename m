Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVENVNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVENVNd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVENVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:13:32 -0400
Received: from [81.2.110.250] ([81.2.110.250]:52178 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261490AbVENVN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:13:29 -0400
Subject: Re: [rfc/patch] libata -- port configurable delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42853687.1050402@pobox.com>
References: <20050513185850.GA5777@kvack.org>
	 <1116019231.26693.499.camel@localhost.localdomain>
	 <42853687.1050402@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116105095.20545.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 May 2005 22:11:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-05-14 at 00:21, Jeff Garzik wrote:
> > If your chipset implements the 400nS lockout in hardware it certainly
> > seems to make sense. Nice to know someone has put it in hardware
> 
> No, it's just mostly irrelevant under SATA.

libata is for PATA devices too.

> The ATA registers are transmitted to the device in a single packet, 
> called a FIS, when the Command or Device Control register is written.
> 
> When the device updates its status, or completes a command, it sends a 
> FIS from device to controller, instructing the controller to update its 
> cached copy of the Status register.

The controller in ATA style behaviour isn't required to have the status
register valid at the point the FIS is written. It probably does but it
isn't required.

