Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUECNLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUECNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUECNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:11:25 -0400
Received: from ns.suse.de ([195.135.220.2]:54415 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263685AbUECNLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:11:23 -0400
Subject: Re: Deadlock problems
From: Chris Mason <mason@suse.com>
To: Jan Kara <jack@ucw.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Eugene Crosser <crosser@average.org>
In-Reply-To: <20040503115837.GC360@atrey.karlin.mff.cuni.cz>
References: <20040503115837.GC360@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1083589880.1607.9.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 09:11:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 07:58, Jan Kara wrote:
>   Hi Andrew!
> 
>   I've found hard to fix problem causing deadlock - call path is
> generally following:
>   some operation -> quota code -> read/write quota -> vfs -> needs a page ->
> shrink caches -> free inodes -> free quota -> Ouch... (we need to acquire
> some lock which is already held by the quota code)
> 
Ugh, for some reason I thought we were avoiding this one in 2.6.  This
is why I made kinoded for the quota patches in 2.4.x

-chris


