Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUB0Us0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUB0Us0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:48:26 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:57864 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263093AbUB0UsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:48:25 -0500
Date: Fri, 27 Feb 2004 20:48:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: torvalds@osdl.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Do not register NULL /dev entries on devfs
Message-ID: <20040227204817.A4877@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>, torvalds@osdl.org,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0402271831080.19454@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58L.0402271831080.19454@logos.cnet>; from marcelo.tosatti@cyclades.com on Fri, Feb 27, 2004 at 06:36:47PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 06:36:47PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Faced this problem where "/dev/<NULL>x" entries got created while loading
> the cyclades driver with devfs.
> 
> Several drivers do not set driver->devfs_name, so better skip registration
> for those.

No, fix the drivers instead.

