Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTEASev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTEASev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:34:51 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:22791 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261887AbTEASet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:34:49 -0400
Date: Thu, 1 May 2003 19:47:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030501194711.A24651@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030429155731.07811707.akpm@digeo.com> <20030501153325.A15458@infradead.org> <20030501114229.64fbbfa2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030501114229.64fbbfa2.akpm@digeo.com>; from akpm@digeo.com on Thu, May 01, 2003 at 11:42:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 11:42:29AM -0700, Andrew Morton wrote:
> I had two concerns with smalldevfs:
> 
> - It's dropping a semaphore (i_sem?) during its synchronous userspace
>   callout.  That was for deadlock avoidance and may have introduced a race.

That's a design bug carried over from the old devfs and needs fixing by
changing the way userspace notification works.

> - The new userspace doesn't support the compatibility names.  Just some
>   config file, or a tarball or a dang shell script full of `ln -s'
>   calls would fix that up, I think.

Well, that's easily fixable.  Does someone actually have a copy if the
devfs_helper tarball around?  Adam's seems to have vanished and his
ftp server is down, too.

