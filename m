Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263759AbSJHUm6>; Tue, 8 Oct 2002 16:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbSJHUmK>; Tue, 8 Oct 2002 16:42:10 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:55306 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263291AbSJHUl7>; Tue, 8 Oct 2002 16:41:59 -0400
Date: Tue, 8 Oct 2002 21:47:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008214736.A22169@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org> <200210082114.00576.agruen@suse.de> <20021008202038.A15692@infradead.org> <20021008214143.O2717@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008214143.O2717@redhat.com>; from sct@redhat.com on Tue, Oct 08, 2002 at 09:41:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 09:41:43PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, Oct 08, 2002 at 08:20:38PM +0100, Christoph Hellwig wrote:
> > On Tue, Oct 08, 2002 at 09:14:00PM +0200, Andreas Gruenbacher wrote:
> > > Users might just fill up all xattr space leaving no space for ACLs (or 
> > > similar). If user xattrs are disabled this can no longer occur, so some 
> > > administrators might be happy to have a choice.
> > 
> > Umm, that's why we have quota..
> 
> It's the per-inode extended attribute space that's at risk here,
> quotas don't help.

Well, that's a more important problem.  But I doubt a hack to just turn off
user xattrs is the right fix then.  A static reservation for ACLs or just
totally separating them (like in XFS) seems more måture.
