Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVHZTAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVHZTAj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVHZTAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:00:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1170 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1030187AbVHZTAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:00:39 -0400
Date: Fri, 26 Aug 2005 20:03:39 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: blaisorblade@yahoo.it
Cc: torvalds@osdl.org, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
Message-ID: <20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk>
References: <20050826145749.03BFE24D661@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826145749.03BFE24D661@zion.home.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 04:57:44PM +0200, blaisorblade@yahoo.it wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Update hppfs for the symlink functions prototype change.
> Should be trivial, but please verify it's correct.
> 
> Yes, I know the code I leave there is still _bogus_, see next patch for this.

Assuming that the next patch was "hppfs: fix symlink error path",
you've still left BS in there - 

>  	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);

is obviously wrong; at the very least you need vfsmount in there.
