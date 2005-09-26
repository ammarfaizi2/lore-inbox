Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVIZQqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVIZQqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVIZQqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:46:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46533 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932400AbVIZQqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:46:04 -0400
Date: Mon, 26 Sep 2005 17:46:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over time.
Message-ID: <20050926164603.GQ7992@ftp.linux.org.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org> <Pine.LNX.4.60.0509261654550.29344@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0509260926160.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509260926160.3308@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 09:41:14AM -0700, Linus Torvalds wrote:
> Yes, and sparse will actually conform to gcc behaviour. I think we had a 
> warning about it, but it's sadly quite common in the kernel ;p
 
No, they are not.  unsigned _is_ common (mostly from 1U<<31).  Going
beyond 32 bits is done in a handful of cases, NTFS ones being at least
half of the entire pile.
