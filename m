Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWFAUUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWFAUUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWFAUUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:20:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13479 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030278AbWFAUUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:20:47 -0400
Date: Thu, 1 Jun 2006 22:20:45 +0200
From: Olaf Hering <olh@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060601202045.GA32423@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de> <200606011617.03166.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200606011617.03166.mason@suse.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Jun 01, Chris Mason wrote:

> I think this will work (but have not tested it).  Another option is to create 
> a read_cache_page that pins the page via a page flag 
> that invalidate_mapping_pages will honor.

PageLocked or PageDirty, the latter only with a mb().
