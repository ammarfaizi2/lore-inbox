Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWHKTnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWHKTnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWHKTnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:43:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:62420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932332AbWHKTnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:43:11 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc3-mm2 - OOM storm
From: Mike Galbraith <efault@gmx.de>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <44DC78A3.5010605@free.fr>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <44DAF6A4.9000004@free.fr> <20060810021957.38c82311.akpm@osdl.org>
	 <44DBBF2B.2050605@free.fr>  <44DC78A3.5010605@free.fr>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 21:50:41 +0000
Message-Id: <1155333041.6013.20.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 14:31 +0200, Laurent Riffard wrote:
> L
> >> Also, are you able to determine whether the problem is specific to `rpm
> >> -V'?  Are you able to make the leak trigger using other filesystem
> >> workloads?
> > 
> > Will try...
> 
> No luck. For example, "find /usr -type f -print0 | xargs -0 cat > /dev/null" 
> does not trigger the problem.

I spent some time looking over what I thought was the obvious candidate,
but alas, no cigar.  Not surprising since Andrew can't reproduce it. 

> # mount
> /dev/mapper/vglinux1-lvroot on / type ext3 (rw)
> /dev/mapper/vglinux1-lvusr on /usr type reiserfs (ro)
> /dev/mapper/vglinux1-lvvar on /var type ext3 (rw)

Mine is the plainest ext3 config imaginable.

> >> If it's specific to `rpm -V' then perhaps direct-io is somehow causing
> >> pagecache leakage.  That would be a bit odd.

It seems odd at the moment.

	-Mike

