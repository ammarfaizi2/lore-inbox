Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbULUSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbULUSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbULUSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:43:24 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:10468 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261865AbULUSnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:43:11 -0500
Date: Tue, 21 Dec 2004 19:43:04 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041221184304.GF16913@fi.muni.cz>
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209215414.GA21503@infradead.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
: > On Thu, Dec 09, 2004 at 01:59:18PM +0100, Jan Kasprzak wrote:
: > > I have seen the strange problem on our NFS server: yesterday I have
: > > found an empty file owned by UID 0/GID 0 and st_mode == 0 in my home
: > > directory (ls -l said "?--------- 1 root root 0 <date> <filename>").
[...]
: If it's really st_mode I suspect it's a different problem.  Can you retry
: with current oss.sgi.com CVS (or the patch below).  Note that this patch
: breaks xfsdump unfortunately, we're looking into a fix.
: 
: > > Maybe some data is flushed in an incorrect order?
: > 
: > Maybe  :)
: 
: No, the problem I've fixed was related to XFS getting the inode version
: number wrong - or at least different than NFSD expects.
: 
	We have applied these two patches to 2.6.10-rc2, but this
does not help. A few minutes ago I've got the "?----------" file
again from my test script. This time it took >4 hours (it was
about an hour or so without this patch).

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
