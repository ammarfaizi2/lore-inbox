Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVK1WoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVK1WoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVK1WoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:44:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28388 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932267AbVK1WoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:44:10 -0500
Date: Tue, 29 Nov 2005 09:43:57 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] remove broken direct I/O size ioctl
Message-ID: <20051129094357.G7047179@wobbly.melbourne.sgi.com>
References: <20051128222501.GA7238@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051128222501.GA7238@lst.de>; from hch@lst.de on Mon, Nov 28, 2005 at 11:25:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 11:25:01PM +0100, Christoph Hellwig wrote:
> This ioctl tries to second guess direct I/O parameters which aren't
> a filesystem drivers business and shouldn't be exposed as an ioctl
> to start with.

Unfortunately there are some applications that will now start
to see errors from this ioctl if we go this route - whereas
before they would've been "functional", now they will break.
So, I think we need a different solution here.  Yes, I agree
its a stupid call to have on Linux, but here we are, and apps
ported straight from IRIX have been made to use this.

cheers.

-- 
Nathan
