Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUDTB11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUDTB11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 21:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDTB11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 21:27:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:22444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262043AbUDTB10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 21:27:26 -0400
Date: Mon, 19 Apr 2004 18:26:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: hch@infradead.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-Id: <20040419182657.7870aee9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
References: <20040418230131.285aa8ae.akpm@osdl.org>
	<20040419202538.A15701@infradead.org>
	<Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 19 Apr 2004, Christoph Hellwig wrote:
> 
> > 4-autofs4-2.6.0-expire-20040405.patch exports vfsmount_lock which is probably
> > not exactly a good design.  It's only used by autofs4_may_umount which isn't
> > autofs-specific at all.
> > 
> 
> Sorry Christoph, your recommendation is?
> 

May as well rename that function to may_umount(), document it, suck it into
fs/namespace.c or fs/namei.c and export it to modules.

That does increase the size of the static kernel a little, so arguably we
shouldn't make this change until/unless we see a second user of the
function.

