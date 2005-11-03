Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbVKCRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVKCRFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVKCRFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:05:45 -0500
Received: from thunk.org ([69.25.196.29]:64729 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030384AbVKCRFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:05:45 -0500
Date: Thu, 3 Nov 2005 12:05:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nathan Scott <nathans@sgi.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051103170527.GA7113@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Nathan Scott <nathans@sgi.com>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com> <20051102233629.GD6759@fi.muni.cz> <20051103104956.B6081538@wobbly.melbourne.sgi.com> <20051103000317.GE6759@fi.muni.cz> <20051103111115.C6081538@wobbly.melbourne.sgi.com> <1131021949.18848.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131021949.18848.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 12:45:49PM +0000, Alan Cox wrote:
> On Iau, 2005-11-03 at 11:11 +1100, Nathan Scott wrote:
> > On Thu, Nov 03, 2005 at 01:03:17AM +0100, Jan Kasprzak wrote:
> > > : it would only ever be uninitialised, previously-free space.
> > > 
> > > 	Yes, but an old data from previously deleted files
> > > (sendmail's temporary files, vim save files, etc) may contain
> > > a sensitive information.
> > 
> > Indeed.  But this is a generic issue affecting most filesystems;
> > its not specific to XFS as your original mail claimed.
> 
> Very true. You can use ext3 in data journalling mode if this is a
> concern but that guarantee has a performance cost

The default ordered journalling mode solves this problem at a much
lower cost.

						- Ted
