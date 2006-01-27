Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWA0D1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWA0D1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWA0D1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:27:24 -0500
Received: from kanga.kvack.org ([66.96.29.28]:21937 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030281AbWA0D1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:27:24 -0500
Date: Thu, 26 Jan 2006 22:23:10 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
Message-ID: <20060127032307.GI10409@kvack.org>
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <20060127002331.GH10409@kvack.org> <43D96AEC.4030200@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D96AEC.4030200@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 04:35:56PM -0800, Matthew Dobson wrote:
> Ummm...  ok?  But with only a simple flag, how do you know *which* mempool
> you're trying to use?  What if you want to use a mempool for a non-slab
> allocation?

Are there any?  A quick poke around has only found a couple of places 
that use kzalloc(), which is still quite effectively a slab allocation.  
There seems to be just one page user, the dm-crypt driver, which could 
be served by a reservation scheme.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
