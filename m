Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269682AbUICNHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269682AbUICNHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:04:58 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:41221 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269663AbUICNEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:04:51 -0400
Date: Fri, 3 Sep 2004 14:04:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
Message-ID: <20040903140449.A4253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>,
	umbrella-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org> <413865B4.7080208@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <413865B4.7080208@cs.aau.dk>; from ks@cs.aau.dk on Fri, Sep 03, 2004 at 02:38:12PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 02:38:12PM +0200, Kristian Sørensen wrote:
> Is there another way to get it? We also get an inodepointer from the LSM 
> hook. As far as I know, the file struct has an entry called vfs_mount, 
> which has an entry called root_mnt - could this be used? (and if so, how 
> do I get from the Inode to the file struct? :-/ )

Witch a struct file you can use d_path which gives you a canonical path
in the _current_ _namespace_.

What do you want to do with the path anyway?

