Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVAYOSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVAYOSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVAYOSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:18:47 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:65461 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261948AbVAYOSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:18:37 -0500
Message-ID: <41F65514.3040707@xfs.org>
Date: Tue, 25 Jan 2005 08:17:56 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Andi Kleen'" <ak@muc.de>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Mel Gorman'" <mel@csn.ul.ie>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Memory Management List'" <linux-mm@kvack.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Grant Grundler'" <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
References: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mukker, Atul wrote:

> 
> LSI would leave no stone unturned to make the performance better for
> megaraid controllers under Linux. If you have some hard data in relation to
> comparison of performance for adapters from other vendors, please share with
> us. We would definitely strive to better it.
> 
> The megaraid driver is open source, do you see anything that driver can do
> to improve performance. We would greatly appreciate any feedback in this
> regard and definitely incorporate in the driver. The FW under Linux and
> windows is same, so I do not see how the megaraid stack should perform
> differently under Linux and windows?

It is not the driver per se, but the way the memory which is the I/O
source/target is presented to the driver. In linux there is a good
chance it will have to use more scatter gather elements to represent
the same amount of data.

Steve
