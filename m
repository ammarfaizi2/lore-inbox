Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVA1CPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVA1CPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVA1CPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:15:36 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:42397 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261392AbVA1CPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:15:30 -0500
Date: Thu, 27 Jan 2005 18:15:30 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: netdev-2.6 queue updated
Message-ID: <20050128021530.GB19150@hexapodia.org>
References: <41F980A0.8020905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F980A0.8020905@pobox.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 07:00:32PM -0500, Jeff Garzik wrote:
> The attached changelog describes what I just pushed out to BitKeeper 
> (and what should be appearing in the next -mm release from Andrew).
> 
> Note to BK users:  please re-clone netdev-2.6, don't just 'bk pull'.

It's much more efficient to do
% bk undo -a`bk repogca`
(which deletes everything in the local repo that's not in the parent)
rather than pulling the entire repo over the wire again. [1]

You can check what would be deleted by this command with "bk changes -L"
similar to how you can "bk changes -R" to figure out what would be
pulled.

[1] Well, actually, it isn't *quite* that simple; in certain cases,
    repogca will delete more than it needs to.  But it's still more
    efficient than a re-pull.

-andy
