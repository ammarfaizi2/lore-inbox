Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUJ2VHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUJ2VHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbUJ2VAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:00:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:46767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263484AbUJ2UqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:46:05 -0400
Date: Fri, 29 Oct 2004 13:45:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes to fs/buffer.c?
In-Reply-To: <20041029133420.76a758b3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0410291343510.28839@ppc970.osdl.org>
References: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
 <20041029133420.76a758b3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Andrew Morton wrote:
>
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > Is it ok to export 
> >  create_buffers() and to make __set_page_buffers() static inline and move 
> >  it to include/linux/buffer.h?
> 
> ho, hum - if you must ;)
> 
> I'd be inclined to rename it to attach_page_buffers() or something though -
> create_buffers() is a bit generic-sounding.

Also, I think we should at least start out limiting it to GPL-only usage. 
Those page buffers are pretty intertwined with the VM usage, I'd hate to 
see people think this is some kind of external interface..

		Linus
