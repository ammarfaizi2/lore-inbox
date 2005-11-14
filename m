Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVKNTxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVKNTxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKNTxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:53:42 -0500
Received: from main.gmane.org ([80.91.229.2]:35551 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751269AbVKNTxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:53:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 14:47:54 -0500
Message-ID: <dlapl2$621$1@sea.gmane.org>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain> <dlal2q$kdo$1@sea.gmane.org> <20051114190007.GA72044@dspnet.fr.eu.org> <20051114191850.GI20614@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> On Mon, Nov 14, 2005 at 08:00:07PM +0100, Olivier Galibert wrote:
>> Couldn't ndiswrapper have its own private stack to switch to when
>> calling the windows driver, or are there still things hanging off the
>> end of the stack area?

This has been discussed sometime back. Search for "ndiswrapper" on lkml.
See, e.g.,
http://marc.theaimsgroup.com/?l=linux-kernel&m=112602638406796&w=2

> It's possible, but would need a change to how the kernel finds the thread
> local data (which is currently done by masking off the stack pointer).
> There are certainly a few ways of doing this, like using tr to find out
> which cpu we're on and then indexing into the thread info state.

If any such alternate ways are used instead of relying on stack pointer, we
could have implemented private stacks for threads in ndiswrapper (and
driverloader).

Giri

