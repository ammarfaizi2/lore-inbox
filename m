Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWAJSet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWAJSet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWAJSet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:34:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750804AbWAJSes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:34:48 -0500
Date: Tue, 10 Jan 2006 10:34:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
cc: Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
In-Reply-To: <43C3F986.4090209@mbligh.org>
Message-ID: <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
 <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org>
 <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
 <43C3F986.4090209@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jan 2006, Martin Bligh wrote:
> 
> The non-1GB-aligned ones need to be disbarred when PAE is on, I think.

Well, right now _all_ the non-3:1 cases need to be disbarred. I think we 
depend on the kernel mapping only ever being the _one_ last entry in the 
top-level page table, which is only true with the 3:1 mapping.

But I didn't check.

		Linus
