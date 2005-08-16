Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVHPTil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVHPTil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVHPTil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:38:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56450 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932322AbVHPTil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:38:41 -0400
Date: Tue, 16 Aug 2005 20:38:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] clean up missing overflow check in get_blkdev_list
Message-ID: <20050816193835.GA551@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Neil Horman <nhorman@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, torvalds@osdl.org
References: <20050816184813.GH16120@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816184813.GH16120@hmsendeavour.rdu.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 02:48:13PM -0400, Neil Horman wrote:
> Patch to clean up missing overflow check in get_blkdev_list.  the printf which
> adds the "Block Devices" string in /proc/devices can overflow the presented page
> if get_chrdev_list eats up the entire 4k space. Tested by myself, with good
> results.

Please switch /proc/device over to the proper seq_file model instead.

