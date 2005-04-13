Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVDMDHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVDMDHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVDMDEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:04:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23529 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262064AbVDMDAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:00:09 -0400
Date: Wed, 13 Apr 2005 04:00:02 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, bfennema@falcon.csc.calpoly.edu,
       linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/udf/inode.c: fix a check after use
Message-ID: <20050413030002.GS8859@parcelfarce.linux.theplanet.co.uk>
References: <20050413021737.GR3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413021737.GR3631@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 04:17:37AM +0200, Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.

Bullshit.  *Please*, read the surrounding code.  Again, we never get
to calling that function if we would pass NULL in its first argument.

It's BUG_ON(), not printk().  And oops on entering the function in
question is just as good as BUG_ON().  Remove check and be done with
that.
