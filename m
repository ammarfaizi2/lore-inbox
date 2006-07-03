Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWGCJFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWGCJFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWGCJFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:05:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38298 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750934AbWGCJFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:05:36 -0400
Date: Mon, 3 Jul 2006 10:05:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 6/8] inode-diet: Move i_cindex from struct inode to struct file
Message-ID: <20060703090532.GA8242@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060703005333.706556000@candygram.thunk.org> <20060703010023.430751000@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703010023.430751000@candygram.thunk.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 08:53:39PM -0400, Theodore Ts'o wrote:
> inode.i_cindex isn't initialized until the character device is opened
> anyway, and there are far more struct inodes in memory than there are
> struct file.  So move the cindex field to file.f_cindex, and change
> the one(!) user of cindex to use file pointer, which is in fact simpler.

I think you got a pretty clear NACK from Al on this one.

