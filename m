Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWGCJGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWGCJGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWGCJGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:06:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41114 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750989AbWGCJGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:06:45 -0400
Date: Mon, 3 Jul 2006 10:06:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 7/8] inode-diet: Use a union for i_blocks and i_size, i_rdev and i_devices
Message-ID: <20060703090642.GB8242@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060703005333.706556000@candygram.thunk.org> <20060703010023.720991000@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703010023.720991000@candygram.thunk.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 08:53:40PM -0400, Theodore Ts'o wrote:
> The i_blocks and i_size fields are only used for regular files.  So we
> move them into the union, along with i_rdev and i_devices, which are
> only used by block or character devices.

Can we please make this a named instead of unnamed union so everyone still
using the fields will trip up?  To reduce the impact a few more imajor/iminor
conversions might be needed were direct references to i_rdev crept back in.

