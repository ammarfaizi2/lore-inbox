Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTBOK5l>; Sat, 15 Feb 2003 05:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTBOK5l>; Sat, 15 Feb 2003 05:57:41 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:18185 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261295AbTBOK5l>; Sat, 15 Feb 2003 05:57:41 -0500
Date: Sat, 15 Feb 2003 11:07:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       "Theodore T'so" <tytso@mit.edu>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Message-ID: <20030215110732.A17564@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Theodore T'so <tytso@mit.edu>
References: <200302112018.58862.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302112018.58862.agruen@suse.de>; from agruen@suse.de on Tue, Feb 11, 2003 at 08:18:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:18:58PM +0100, Andreas Gruenbacher wrote:
> The third to fifth are all steps towards trusted extended attributes, 
> which are useful for privileged processes (mostly daemons). One use for 
> this is Hierarchical Storage Management, in which a user space daemon 
> stores online/offline information for files in trusted EA's, and the 
> kernel communicates requests to bring files online to that daemon. This 
> class of EA's will also find its way into XFS and ReiserFS, and 
> expectedly also into JFS in this form. (Trusted EAs are included in the 
> 2.4.19/2.4.20 patches as well.)

Please don't do the ugly flags stuff.  We have fsuids and fsgids for exactly
that reason (and because we're still lacking a credentials cache..).  


