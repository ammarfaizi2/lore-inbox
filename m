Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVAXOLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVAXOLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVAXOLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:11:24 -0500
Received: from mail.suse.de ([195.135.220.2]:42726 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261521AbVAXOLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:11:13 -0500
Subject: Re: [ea-in-inode 0/5] Further fixes
From: Andreas Gruenbacher <agruen@suse.de>
To: tridge@osdl.org
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16884.56071.773949.280386@samba.org>
References: <20050120020124.110155000@suse.de>
	 <16884.8352.76012.779869@samba.org> <200501232358.09926.agruen@suse.de>
	 <200501240032.17236.agruen@suse.de>  <16884.56071.773949.280386@samba.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106575864.1489.103.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 Jan 2005 15:11:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 12:24, Andrew Tridgell wrote:
> Andreas,
> 
> I'm starting to think the bug I saw is hardware error. [...]

The patch in my prevous message (Mon, 24 Jan 2005 00:32:16 +0100) still
makes sense, if only for cleanliness: Without it, the i_extra_isize
field of reserved inodes is zeroed even though we're not allowing
in-inode attributes there. It's probably better to leave the garbage in
these inodes untouched; we could in theory disable in-inode attributes
for arbitrary inodes with this change.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

