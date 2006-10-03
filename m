Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWJCGXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWJCGXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 02:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWJCGXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 02:23:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932466AbWJCGXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 02:23:30 -0400
Date: Mon, 2 Oct 2006 23:19:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       esandeen@redhat.com, Badari Pulavarty <pbadari@us.ibm.com>,
       Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
Message-Id: <20061002231945.f2711f99.akpm@osdl.org>
In-Reply-To: <4521F865.6060400@sandeen.net>
References: <20061002194711.GA1815@redhat.com>
	<20061003052219.GA15563@redhat.com>
	<4521F865.6060400@sandeen.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 00:43:01 -0500
Eric Sandeen <sandeen@sandeen.net> wrote:

> Dave Jones wrote:
> 
> > So I managed to reproduce it with an 'fsx foo' and a
> > 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
> > a vanilla 2.6.18 with none of the Fedora patches..
> > 
> > I'll give 2.6.18-git a try next.
> > 
> > 		Dave
> > 
> > ----------- [cut here ] --------- [please bite here ] ---------
> > Kernel BUG at fs/buffer.c:2791
> 
> I had thought/hoped that this was fixed by Jan's patch at 
> http://lkml.org/lkml/2006/9/7/236 from the thread started at 
> http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
> first by going through that new codepath....

Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
Badari was hitting that BUG and was able to confirm that Jan's patch
(3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
it.
