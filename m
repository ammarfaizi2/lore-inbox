Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbRGTKjO>; Fri, 20 Jul 2001 06:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266913AbRGTKjE>; Fri, 20 Jul 2001 06:39:04 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:18558 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266911AbRGTKiq>; Fri, 20 Jul 2001 06:38:46 -0400
Date: Thu, 19 Jul 2001 23:36:25 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Peter J. Braam" <braam@clusterfilesystem.com>
Cc: linux-kernel@vger.kernel.org, mason@suse.com, sct@redhat.com
Subject: Re: modules/ksyms/filenames
Message-ID: <20010719233625.X6826@redhat.com>
In-Reply-To: <20010719155400.E27553@lustre.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010719155400.E27553@lustre.clusterfilesystem.com>; from braam@clusterfilesystem.com on Thu, Jul 19, 2001 at 03:54:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

On Thu, Jul 19, 2001 at 03:54:00PM -0600, Peter J. Braam wrote:
> I'm trying to export a symbol (journal_begin/end) from
> fs/reiserfs/journal.c. To export the symbols I added to the Makefile:
> export-objs := journal.o
> 
> There is also a file fs/jbd/journal.c which exports symbols. 
> 
> It seems that the two journal.ver files in include/modules/*.ver get
> clobbered.
> 
> Short of renaming files, is there a good solution for this? 

Yes, you can add the EXPORT_SYMBOL to a different source file --- you
don't have to do the export from the same file which defines the
symbol.  linux/kernel/ksyms.c contains exports from all over the rest
of the kernel, for example.  If you pick a reiserfs source file which
already exports symbols and add your exports there, I _think_ it
should work OK.

Cheers,
 Stephen
