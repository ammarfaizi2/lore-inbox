Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVAXLmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVAXLmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVAXLmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:42:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261499AbVAXLmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:42:38 -0500
Date: Mon, 24 Jan 2005 11:42:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Tridgell <tridge@osdl.org>
Cc: Andreas Gruenbacher <agruen@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ea-in-inode 0/5] Further fixes
Message-ID: <20050124114211.GA28832@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Tridgell <tridge@osdl.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@clusterfs.com>,
	Alex Tomas <alex@clusterfs.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050120020124.110155000@suse.de> <16884.8352.76012.779869@samba.org> <200501232358.09926.agruen@suse.de> <200501240032.17236.agruen@suse.de> <16884.56071.773949.280386@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16884.56071.773949.280386@samba.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:24:55PM +1100, Andrew Tridgell wrote:
> Andreas,
> 
> I'm starting to think the bug I saw is hardware error. I just got this
> while trying to reproduce it tonight:
> 
> Jan 24 02:43:32 dev4-003 kernel: qlogicfc0 : abort failed
> Jan 24 02:43:32 dev4-003 kernel: qlogicfc0 : firmware status is 4000 4
> Jan 24 02:43:32 dev4-003 kernel: scsi: Device offlined - not ready after error recovery: host 3 
> channel 0 id 1 lun 0
> 
> I'll see if I can get this confirmed tomorrow.

Don't use the qlogicfc driver ever but qla2xxx instead.  It's only still
in the kernel tree because davem's a lazy bastard :)

