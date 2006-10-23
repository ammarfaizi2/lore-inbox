Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWJWLLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWJWLLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWJWLLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:11:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34708 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751901AbWJWLLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:11:33 -0400
Date: Mon, 23 Oct 2006 13:10:22 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Bryan Henderson <hbryan@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       "H. Peter Anvin" <hpa@zytor.com>, sct@redhat.com, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] ext3: fsid for statvfs
Message-ID: <20061023111022.GA8408@apps.cwi.nl>
References: <Pine.LNX.4.64.0610101131001.10574@sbz-30.cs.Helsinki.FI> <20061010133636.6217a11b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010133636.6217a11b.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 01:36:36PM -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 11:32:13 +0300 (EEST)
> Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> 
> > From: Pekka Enberg <penberg@cs.helsinki.fi>
> > 
> > Update ext3_statfs to return an FSID that is a 64 bit XOR of the 128 bit
> > filesystem UUID as suggested by Andreas Dilger.
> 
> Deja vu.  Gosh, has it really been four years?
> 
> Combatants cc'ed ;)

Ha, you have a memory. To me this seems infinitely long ago.
Google turned up some interesting discussions on dev_t, and the below exchange.

No, at first sight I have no objections to the suggested patch.
(Although I think that fsid is used only for doubtful purposes.)

Andries

-----
Andries Brouwer wrote:
> On Mon, Dec 09, 2002 at 02:15:12PM -0800, H. Peter Anvin wrote:
>
> > > The general idea is that f_fsid contains some random stuff such that
> > > the pair (f_fsid,ino) uniquely determines a file.
>
> > This, of course, is the exact POSIX definition of the st_dev part of
> > struct stat: (st_dev, st_ino) uniquely identifies the file.
>
> Yes, but the difference is that (st_dev, st_ino) only identifies
> the file within a single machine, and may stop working when you
> have NFS mounts.
