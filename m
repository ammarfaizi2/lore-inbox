Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbTHRAjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTHRAjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:39:14 -0400
Received: from holomorphy.com ([66.224.33.161]:24036 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271144AbTHRAjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:39:13 -0400
Date: Sun, 17 Aug 2003 17:40:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Duraid Madina <duraid@octopus.com.au>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: kswapd is having a party
Message-ID: <20030818004026.GT32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Duraid Madina <duraid@octopus.com.au>, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org
References: <3F400B57.2090806@octopus.com.au> <20030818003300.GS32488@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818003300.GS32488@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 09:10:15AM +1000, Duraid Madina wrote:
>> 	Does anyone have _any_ idea what kswapd might actually be doing? I 
>> checked: not a single page was swapped in our out througout the duration 
>> of this test. Is there a chance that spinning on some lock (I have no 
>> idea how LAM does its synchronization), or perhaps even just idling, 
>> might be counted as kswapd0?

On Sun, Aug 17, 2003 at 05:33:00PM -0700, William Lee Irwin III wrote:
> I'd look for dirty memory; kswapd does do some page cleaning, though
> pdflush is supposed to do most of it.

Also, please log vmstat and take regular snapshots of /proc/vmstat.


-- wli
