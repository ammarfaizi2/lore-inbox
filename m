Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUHZJ5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUHZJ5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHZJxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:53:40 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:17643 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268020AbUHZJol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:44:41 -0400
Date: Thu, 26 Aug 2004 02:44:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Rik van Riel <riel@redhat.com>
Cc: mikulas@artax.karlin.mff.cuni.cz, torvalds@osdl.org, hch@lst.de,
       reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826024453.13c2f1e0.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.58.0408260204050.22259@artax.karlin.mff.cuni.cz>
	<Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> If your backup program reads them as a file and restores
> them as a file, you might lose your directory-inside-the-file
> magic.

Encode the magic in the names, by stealing a bit of the existing
filename space to encode it.

Such works pretty well as part of the magic to map long filenames
into DOS 8.3 names on my FAT partitions.

Apps linked with the appropriate Windows library see nice fancy
long names.

The rest of the world, including DOS apps and my Unix backup
scripts, see the primitive 8.3 names, including one or a few
extra files per directory, which are nothing special to them.

So long as these other apps don't presume to know that they can
keep some of the files in an apps directory, and drop others, then
it works well enough.  And no self-respecting general purpose
backup program is going to presume such knowledge anyway.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
