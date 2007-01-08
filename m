Return-Path: <linux-kernel-owner+w=401wt.eu-S1161306AbXAHOIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbXAHOIK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbXAHOIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:08:10 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:45534 "EHLO
	allen.werkleitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161306AbXAHOII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:08:08 -0500
X-Greylist: delayed 1467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 09:08:07 EST
Date: Mon, 8 Jan 2007 14:41:47 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Willy Tarreau <w@1wt.eu>, Linus Torvalds <torvalds@osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Message-ID: <20070108134147.GB5291@linuxtv.org>
References: <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108125819.GA32756@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 84.190.168.38
Subject: Re: How git affects kernel.org performance
X-SA-Exim-Version: 4.2.1 (built Sun, 03 Dec 2006 00:39:09 +0000)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 07:58:19AM -0500, Theodore Tso wrote:
> 
> The fastest and probably most important thing to add is some readahead
> smarts to directories --- both to the htree and non-htree cases.  If
> you're using some kind of b-tree structure, such as XFS does for
> directories, preallocation doesn't help you much.  Delayed allocation
> can save you if your delayed allocator knows how to structure disk
> blocks so that a btree-traversal is efficient, but I'm guessing the
> biggest reason why we are losing is because we don't have sufficient
> readahead.  This also has the advantage that it will help without
> needing to doing a backup/restore to improve layout.

Would e2fsck -D help? What kind of optimization
does it perform?


Thanks,
Johannes
