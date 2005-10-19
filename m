Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbVJSXvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbVJSXvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbVJSXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 19:51:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29568 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751639AbVJSXvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 19:51:10 -0400
From: Neil Brown <neilb@suse.de>
To: "Christopher Friesen" <cfriesen@nortel.com>
Date: Thu, 20 Oct 2005 09:50:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17238.56289.98600.555278@cse.unsw.edu.au>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Rick Niles <fniles@mitre.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 26 ways to set a device driver variable from userland
In-Reply-To: message from Christopher Friesen on Wednesday October 19
References: <1129741246.25383.23.camel@gnupooh.mitre.org>
	<4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com>
	<435691EF.8070406@nortel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 19, cfriesen@nortel.com wrote:
> Kyle Moffett wrote:
> 
> >> (4) sysfs
> 
> > This is ideal for almost all device driver purposes.
> 
> The one thing that I have yet to see a good solution for is 
> transaction-based operations, where userspace passes in something (could 
> be a command, a new value, a query, etc.) and expects some data in return.
> 

knfsd does this sort of stuff with it's own tiny filesystem.

If you look in fs/libfs.c you will see a section headed
  Transaction based IO
which is exactly for this sort of thing.

Currently I think you need to create your own tiny filesystem (which
isn't much effort if you use the stuff in libfs).

I think I'd like this sort of file to be a standard option for sysfs
attributes, but I haven't looked seriously into the possibility yet.

NeilBrown
