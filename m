Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUHWUMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUHWUMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUHWUKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:10:32 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:35080 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267386AbUHWTEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:04:06 -0400
Date: Mon, 23 Aug 2004 20:03:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
Message-ID: <20040823200353.A20114@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>
References: <Xine.LNX.4.44.0408231414270.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231415310.13728-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0408231415310.13728-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Mon, Aug 23, 2004 at 02:16:17PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 02:16:17PM -0400, James Morris wrote:
> This patch replaces the dentry parameter with an inode in the LSM
> inode_{set|get|list}security hooks, in keeping with the ext2/ext3 code.
> dentries are not needed here.

Given that the actual methods take a dentry this sounds like a bad design.
Can;t you just pass down the dentry through all of the ext2 interfaces?

(And again, mid-term these checks should move to the VFS)

