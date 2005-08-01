Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVHAWtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVHAWtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVHAWtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:49:22 -0400
Received: from graphe.net ([209.204.138.32]:5248 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261250AbVHAWsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:48:43 -0400
Date: Mon, 1 Aug 2005 15:48:38 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, mort@sgi.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch] remove sys_set_zone_reclaim()
In-Reply-To: <20050801102903.378da54f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0508011546290.8899@graphe.net>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Andrew Morton wrote:

> (I'm still not sure what happened to the idea of adding a call to "clear
> out this node+zone's pagecache now" rather than "set this noed+zone's
> policy")

Yes, We need the clear this zones page cache functionality. I am not sure what the 
Martin's reclaiming code brings us. Since these patches do not allow the 
clearing of the page cache, we will still have off node allocations. 
