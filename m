Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTFORM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTFORM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:12:59 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:35600 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262423AbTFORMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:12:53 -0400
Date: Sun, 15 Jun 2003 18:26:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: quinlan@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615182642.A19479@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	quinlan@transmeta.com, linux-kernel@vger.kernel.org
References: <20030615160524.GD1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615160524.GD1063@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sun, Jun 15, 2003 at 06:05:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 06:05:24PM +0200, Jörn Engel wrote:
> Hi!
> 
> This thing has been biting me now and again.  "cramfs: wrong magic\n"
> looks like an error condition to most people and thus creates bug
> reports.  But there is no bug per se in having cramfs support in the
> kernel and booting from a jffs2 rootfs.  So instead of teaching the
> users over and over, how about this little one-liner?

Umm, cramfs_fill_super has a silent parameter that's true for
probing the root filesystem.  I'd suggest disabling the printk
completly if it's set.

