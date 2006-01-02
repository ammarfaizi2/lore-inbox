Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWABUjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWABUjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWABUjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:39:40 -0500
Received: from ns1.suse.de ([195.135.220.2]:4050 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751055AbWABUjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:39:39 -0500
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: X86_64 + VIA + 4g problems
Date: Mon, 2 Jan 2006 21:39:29 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5qvTv-8f-17@gated-at.bofh.it> <200601022053.31534.ak@suse.de> <43B989EC.2050704@shaw.ca>
In-Reply-To: <43B989EC.2050704@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601022139.30155.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 21:15, Robert Hancock wrote:

> I'm not sure if this would be an issue with Linux. I would suspect that 
> it could be, if there are indeed such buses that can't support DAC.. In 
> this case the right thing to do would be to reject requests for DMA 
> masks larger than 4GB for devices located on such a bus.

Well, from the original messages in this thread which you so shamelessly
hijacked it is possible VIA PCI bridges might have this problem. If yes
it can be handled in the PCI-DMA API by disallowing DAC for devices
behind such bridges. But before taking such drastic action we need
first need more testing results.

-Andi
