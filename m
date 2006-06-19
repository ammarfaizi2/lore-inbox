Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWFSGl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWFSGl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFSGl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:41:58 -0400
Received: from mx2.mail.ru ([194.67.23.122]:12559 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751006AbWFSGl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:41:57 -0400
Date: Mon, 19 Jun 2006 10:47:21 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060619064721.GA6106@rain.homenetwork>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618175045.GX27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 06:50:45PM +0100, Al Viro wrote:
> 	* block may be bigger than page.  That can cause all sorts of fun
> problems in interaction with our VM, since allocation can affect more than
> one page and that has to be taken into account.

In fact this is not a problem. Blocks in terms of linux VFS
is fragments in terms of UFS. 
And if fragment >4096 we just don't mount such file system.

So we can easily support 32K blocks.

-- 
/Evgeniy

