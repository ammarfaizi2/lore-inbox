Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUHZKnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUHZKnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUHZKnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:43:04 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:15093 "EHLO
	mailrelay01.tugraz.at") by vger.kernel.org with ESMTP
	id S267945AbUHZKke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:40:34 -0400
From: Christian Mayrhuber <christian.mayrhuber@gmx.net>
To: reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 12:45:47 +0200
User-Agent: KMail/1.6.2
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-fsdevel@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
References: <20040824202521.GA26705@lst.de> <20040825163225.4441cfdd.akpm@osdl.org> <1093510983.23289.6.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1093510983.23289.6.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408261245.47734.christian.mayrhuber@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 11:03, Anton Altaparmakov wrote:

> Please don't forget that if the reiser4 features are merged as they are
> now, then we will likely be stuck with the API reiser4 chooses.  There
> will be tools that will rely on it springing up no doubt.
>
> Moving the reiser4 features to VFS later is fine and good, but what if
> the VFS doesn't want the same API for those features?  Either we would
> have to allow reiser4 to continue providing the old API even though the
> VFS now provides a new, shiny API or we would have to break all existing
> API users on reiser4.  Things like "I rebooted into the latest kernel
> and my computer failed to boot because essential app FOO failed to
> access the reiser4 API - Help!" spring to mind.

Andrew Morton wrote:
>b) accept the reiser4-only extensions with a view to turning them into
>   kernel-wide extensions at some time in the future, so all filesystems
>   will offer the extensions (as much as poss) or

If option b) is chosen Reiser4 can become a playground.

There is the reiser4() syscall which you surely don't want to implement for 
other filesystems.
Once there is some experience with this new fancy stuff the dust what
is useful/insecure, etc. and what is not will settle and can be condensed
into a vfs api.
Apps like samba and user scripts will have to be adapted once this is
the case, but this should not be to big a problem if this stuff is marked 
experimental.

People which want something stable can continue to use xattrs and a
magnitude of filesystems for now.

-- 
lg, Chris

