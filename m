Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUBGJHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266688AbUBGJHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:07:11 -0500
Received: from dp.samba.org ([66.70.73.150]:39830 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266687AbUBGJHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:07:09 -0500
Date: Sat, 7 Feb 2004 20:06:35 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Manfreds patch to distribute boot allocations across nodes
Message-ID: <20040207090634.GQ19011@krispykreme>
References: <20040207042559.GP19011@krispykreme> <20040206210428.17ee63db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206210428.17ee63db.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Is this a thing which all NUMA machines want to be doing?

So far we have ppc64 and x86-64. I suspect the others will be OK with
it. 

> Should this not search for the emptiest node?

Allocating things round robin avoids a hot node where everything ends up
being allocated.

> Is non-__init code allowed to call __init code?  I thought that caused
> linkage errors on some setups.  Pretty sure about that.  I think, maybe.

Maybe. Its news to me.

Anton
