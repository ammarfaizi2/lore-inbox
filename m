Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945915AbWJSB0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbWJSB0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945954AbWJSB0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:26:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21910 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1945915AbWJSB0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:26:02 -0400
Date: Thu, 19 Oct 2006 02:26:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Neil Brown <neilb@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
Message-ID: <20061019012600.GR29920@ftp.linux.org.uk>
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk> <1161206763.6095.172.camel@lade.trondhjem.org> <17718.51050.186385.512984@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17718.51050.186385.512984@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 10:31:38AM +1000, Neil Brown wrote:
> > ACK on patches # 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12. I'd be quite happy
> > to get those into mainline ASAP.
> > 
> > I'll defer to Neil for the rest.
> 
> Thanks for the reminder Trond.
> 
> Yes, 
> 
> Acked-By: NeilBrown <neilb@suse.de>
> 
> for 1, 13-25.
> Thanks for doing this - there are some important cleanups in there,
> particular the clear differentiation between err and host_err (not to
> mention the bug fixes!).

err vs. host_err was pretty much the main reason for that series - we kept
getting bugs in that area and sparse can handle that sort of checks just
fine.

Folks, seriously, please run sparse after changes; it's a simple matter of
make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/; nothing tricky and it saves a lot
of potential PITA...
