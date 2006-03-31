Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCaGfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCaGfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCaGfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:35:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751126AbWCaGfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:35:53 -0500
Date: Fri, 31 Mar 2006 07:35:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, jeff@garzik.org, axboe@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org, rpeterso@redhat.com
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331063524.GB31436@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	torvalds@osdl.org, jeff@garzik.org, axboe@suse.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org, rpeterso@redhat.com
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org> <442C440B.2090700@garzik.org> <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org> <442C7EF5.8090703@yahoo.com.au> <20060330184325.35e21117.akpm@osdl.org> <20060330185133.176f8210.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330185133.176f8210.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 06:51:33PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > splice() may not be suitable for such filesystems.
> 
> OK, splice() cuts in at the file_operations level, so sych a clustered
> filesystem _could_ implement it, but none of the code we have there will be
> usable by it.  If the operations in splice.c were to operate at the
> file_operations level (->read, ->write) then probably they could be used
> thusly.

Of course the code would be useable, same as current generic_file_* code
is useable with small wrappers.

