Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVAaR3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVAaR3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVAaR3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:29:11 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:18771 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261274AbVAaR3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:29:05 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,167,1102287600"; 
   d="scan'208"; a="2812603:sNHT22564528"
Message-ID: <41FE6ADF.8030304@fujitsu-siemens.com>
Date: Mon, 31 Jan 2005 18:29:03 +0100
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Discuss][i386] Platform SMIs and their interferance with tsc
  based delay calibration
References: <3rR0g-3aR-11@gated-at.bofh.it> <3s4Tx-1gi-9@gated-at.bofh.it>
In-Reply-To: <3s4Tx-1gi-9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> In particular, I don't see why you didn't just put this in the generic 
> calibrate_delay() routine. You seem to have basically duplicated it, and 
> added the "guess from an external timer" code - and I don't see what's 
> non-generic about that, except for some trivial "what's the current timer" 
> lookup.

The trivial lookup is hidden in the __delay() function. Making it return 
the number of "loops" it actually waited would help having a robust 
generic code.

Regards
Martin
