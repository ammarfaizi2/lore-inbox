Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVJLGLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVJLGLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVJLGLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:11:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932472AbVJLGLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:11:00 -0400
Date: Tue, 11 Oct 2005 23:10:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH
 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
Message-Id: <20051011231015.6a1c4c5b.akpm@osdl.org>
In-Reply-To: <434CA527.90604@sm.sony.co.jp>
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp>
	<433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
	<87psqbxreb.fsf@ibmpc.myhome.or.jp>
	<434CA527.90604@sm.sony.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> wrote:
>
> 
> 
> OGAWA Hirofumi wrote:
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > 
> >>However there's not much point in writing a brand-new function when
> >>write_inode_now() almost does the right thing.  We can share the
> >>implementation within fs-writeback.c.
> > 
> > 
> > Indeed. We use the generic_osync_inode() for it?
> 
> Please let me confirm.
> Using generic_osync_inode(inode, NULL, OSYNC_INODE) instaed of
> sync_inode_wodata(inode) is peferable for changes on fs/open.c,
> even it would write data. Is it correct?
> 

I don't know.  It depends on what you're actually trying to do, and I don't
recall anyone having described that!
