Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbULFVcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbULFVcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbULFVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:32:08 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:7617 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261660AbULFVb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:31:57 -0500
Subject: Re: [BUG] null-pointer deref (perhaps reiserfs3)
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20041206132712.084ac2b3.akpm@osdl.org>
References: <cp02a6$57j$1@sea.gmane.org> <cp21l0$mve$1@sea.gmane.org>
	 <cp2265$pmp$1@sea.gmane.org>  <20041206132712.084ac2b3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 06 Dec 2004 16:34:29 -0500
Message-Id: <1102368869.8908.1.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 13:27 -0800, Andrew Morton wrote:
> Sven Köhler <skoehler@upb.de> wrote:
> >
> > > dd if=/dev/zero of=image bs=1M count=40
> > > mkreiserfs -f image
> > > mount -o loop image /mnt/test
> > > cp -r /etc/ /mnt/test
> > > 
> > > The kernel will Oops, and cp will segfault.
> > 
> > Well, this won't make sense to you, if don't tell you, that "cp -r /etc/ 
> > /mnt/test" copies more, than the reiserfs can take. In other words:
> > reiserfs crashes if there's no more free diskspace.
> > 
> 
> Could you please test 2.6.10-rc3?

Anything 2.6.10-rc1 or newer should fix it, I sent him the reiserfs
small filesystem patch earlier today.

-chris



