Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVKNTVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVKNTVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVKNTVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:21:19 -0500
Received: from kanga.kvack.org ([66.96.29.28]:30151 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751246AbVKNTVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:21:18 -0500
Date: Mon, 14 Nov 2005 14:18:50 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051114191850.GI20614@kvack.org>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain> <dlal2q$kdo$1@sea.gmane.org> <20051114190007.GA72044@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114190007.GA72044@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 08:00:07PM +0100, Olivier Galibert wrote:
> Couldn't ndiswrapper have its own private stack to switch to when
> calling the windows driver, or are there still things hanging off the
> end of the stack area?

It's possible, but would need a change to how the kernel finds the thread 
local data (which is currently done by masking off the stack pointer).  
There are certainly a few ways of doing this, like using tr to find out 
which cpu we're on and then indexing into the thread info state.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
