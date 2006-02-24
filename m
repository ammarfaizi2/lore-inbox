Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWBXD1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWBXD1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 22:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWBXD1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 22:27:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:46745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751823AbWBXD1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 22:27:38 -0500
From: Andi Kleen <ak@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] The idle notifier chain should be atomic
Date: Fri, 24 Feb 2006 04:27:26 +0100
User-Agent: KMail/1.9.1
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0602232218280.19776-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602232218280.19776-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240427.27441.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 04:24, Alan Stern wrote:
 
> In do_IRQ() there's a call to exit_idle(), which calls __exit_idle(), 
> which runs the idle_notifier call chain.  Surely you're not saying that we 
> can do a down_read() in this pathway?

No, but not because it's in an interrupt but because sleeping in the idle
task is illegal.

> And actually the chain's type doesn't seem to make much difference, since
> at the moment there's nothing in the vanilla kernel that registers for the
> idle_notifier chain.

Will come eventually.

-Andi
