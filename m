Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTDXJAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTDXJAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:00:51 -0400
Received: from holomorphy.com ([66.224.33.161]:16552 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261921AbTDXJAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:00:50 -0400
Date: Thu, 24 Apr 2003 02:12:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
Message-ID: <20030424091250.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304240509_MC3-1-35CF-A2DD@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304240509_MC3-1-35CF-A2DD@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli wrote:
>> Spiffy; this should help debug various things.

On Thu, Apr 24, 2003 at 05:06:58AM -0400, Chuck Ebbert wrote:
>   I forgot to mention: try comparing 2.2, 2.4 and 2.5.
>   Also, this is what I've been using to look at interrupt entry
> point alignment.  On 2.4 for sure, and probably on 2.5 you have
> a 1-in-8 chance of getting a pathologically badly aligned timer
> handler on 32-byte cacheline machines every time you compile
> (IRQ 0 entry address & 0x1f == 0x1c.)  OTOH the pagefault handler
> has come up 8-byte aligned every time but I didn't look at the
> source to see if it's coded that way.

I had more in mind using it to verify the correctness of per-node IDT
stuff than checking optimality in general, but it does look very handy.


-- wli
