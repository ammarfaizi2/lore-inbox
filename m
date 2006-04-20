Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWDTURe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWDTURe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDTURd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:17:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23765 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751245AbWDTURd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:17:33 -0400
Date: Thu, 20 Apr 2006 13:17:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org
Subject: Re: Read/Write migration entries: Implement correct behavior in
 copy_one_pte
In-Reply-To: <20060419123911.3bd22ab3.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604201307200.19049@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0604181119480.7814@schroedinger.engr.sgi.com>
 <20060419095044.d7333b21.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604181823590.9747@schroedinger.engr.sgi.com>
 <20060419123911.3bd22ab3.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, KAMEZAWA Hiroyuki wrote:

> BTW, do we manage page table under move_vma() in right way ?

I had a look at it and it seems to be done the right way. The ptl locks
are taken and the vma information is setup before the move. 
remove_migration_ptes() will find the page both in the old and the new 
vma.
