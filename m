Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTDFOhE (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTDFOhD (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:37:03 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:27011 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S262982AbTDFOhC (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:37:02 -0400
Date: Sun, 6 Apr 2003 16:47:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406144734.GN1326@dualathlon.random>
References: <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com> <20030405231008.GI1326@dualathlon.random> <20030405175824.316efe90.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405175824.316efe90.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 05:58:24PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Esepcially those sigbus in the current api
> > would be more expensive than the regular paging internal to the VM and
> > besides the signal it would generate flood of syscalls and kind of
> > duplication of memory management inside the userspace.
> 
> That went away.  We now encode the file offset in the unmapped ptes, so the
> kernel's fault handler can transparently reestablish the page.

if you put the file offset in the pte, you will break the max file
offset that you can map, that at least should be recoded with a cookie
like we do with the swap space

Andrea
