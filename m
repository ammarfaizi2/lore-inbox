Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263957AbUDVLpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbUDVLpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbUDVLpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:45:12 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:12562 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263957AbUDVLpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:45:09 -0400
Date: Thu, 22 Apr 2004 12:45:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@inf.bme.hu>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fmount system call
Message-ID: <20040422124503.A20320@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <mszeredi@inf.bme.hu>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <200404221054.i3MAsOJ06500@kempelen.iit.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404221054.i3MAsOJ06500@kempelen.iit.bme.hu>; from mszeredi@inf.bme.hu on Thu, Apr 22, 2004 at 12:54:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 12:54:24PM +0200, Miklos Szeredi wrote:
> This patch adds a new fmount() system call, which is exactly the same
> as mount(), except the second parameter (mount target) is a file
> descriptor instead of a path.
> 
> The main advantage is that caller can check permissions on target
> without rename races.  This can be done without fmount(), by doing
> chdir() + mount("."), but this only works for directories and uses the
> CWD which can be slightly tricky to restore.

While I like the idea of fmount I think we should use the chance to untangle
the mess the other mount paramters are.

