Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTHRAby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271174AbTHRAbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:31:53 -0400
Received: from holomorphy.com ([66.224.33.161]:22756 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271152AbTHRAbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:31:52 -0400
Date: Sun, 17 Aug 2003 17:33:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Duraid Madina <duraid@octopus.com.au>
Cc: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: kswapd is having a party
Message-ID: <20030818003300.GS32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Duraid Madina <duraid@octopus.com.au>, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org
References: <3F400B57.2090806@octopus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F400B57.2090806@octopus.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 09:10:15AM +1000, Duraid Madina wrote:
> 	Does anyone have _any_ idea what kswapd might actually be doing? I 
> checked: not a single page was swapped in our out througout the duration 
> of this test. Is there a chance that spinning on some lock (I have no 
> idea how LAM does its synchronization), or perhaps even just idling, 
> might be counted as kswapd0?

I'd look for dirty memory; kswapd does do some page cleaning, though
pdflush is supposed to do most of it.


-- wli
