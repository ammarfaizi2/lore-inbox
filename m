Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTFORac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTFORac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:30:32 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:42000 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262445AbTFORa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:30:26 -0400
Date: Sun, 15 Jun 2003 18:44:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615184417.A19712@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615173926.GH1063@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sun, Jun 15, 2003 at 07:39:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:39:26PM +0200, Jörn Engel wrote:
> > Umm, cramfs_fill_super has a silent parameter that's true for
> > probing the root filesystem.  I'd suggest disabling the printk
> > completly if it's set.
> 
> Good idea, but only at first glance.  cramfs_fill_super() always gets
> called with silent=1.  So if "(!silent) printk(...);" is functionally
> equivalent to ";".

It's not.  The rootfs is mounted with the (grossly misnamed) MS_VERBOSE
flag which translates to the last argument of the fill_super callback
set to 1.

