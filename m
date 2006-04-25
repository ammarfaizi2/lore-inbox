Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWDYK0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWDYK0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDYK0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:26:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932179AbWDYK0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:26:33 -0400
Date: Tue, 25 Apr 2006 11:26:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
Message-ID: <20060425102628.GA26219@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1145636030.3856.102.camel@quoit.chygwyn.com> <20060423075525.GP6075@schatzie.adilger.int> <1145886796.3856.161.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145886796.3856.161.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:53:16PM +0100, Steven Whitehouse wrote:
> > Actually, the 0x0080000 flag has been reserved by e2fsprogs for ext3
> > extents for a while already.  AFAICS, there are no other flags in the
> > current e2fsprogs that aren't listed above.
> > 
> So if I call that one IFLAG_EXTENT, then I presume that will be ok?
> What about the 0x00040000 flag? That would seem to be a gap in the
> sequence (ignoring GFS flags for now), so should I leave that reserved
> for use by ext2/3 as well?

note that at least reiserfs, jfs snd xfs seem to use additional flags aswell.
It would be really helpful if we could get a linux/fflags.h that collects all
of having them spread all over.  Anyone volunteering to create it?

