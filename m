Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJ1OzP>; Mon, 28 Oct 2002 09:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261287AbSJ1OzP>; Mon, 28 Oct 2002 09:55:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:48646 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261281AbSJ1OzP>; Mon, 28 Oct 2002 09:55:15 -0500
Date: Mon, 28 Oct 2002 15:01:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rob Landley <landley@trommello.org>
Cc: Kenneth Johansson <ken@kenjo.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andreas Haumer <andreas@xss.co.at>, linux-kernel@vger.kernel.org,
       willy@w.ods.org
Subject: Re: rootfs exposure in /proc/mounts
Message-ID: <20021028150122.A16200@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rob Landley <landley@trommello.org>,
	Kenneth Johansson <ken@kenjo.org>, Jeff Garzik <jgarzik@pobox.com>,
	Andreas Haumer <andreas@xss.co.at>, linux-kernel@vger.kernel.org,
	willy@w.ods.org
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <1035763409.4176.5.camel@tiger> <20021028001831.A31614@infradead.org> <200210271917.32650.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210271917.32650.landley@trommello.org>; from landley@trommello.org on Sun, Oct 27, 2002 at 08:17:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On Sun, 2002-10-27 at 16:09, Christoph Hellwig wrote:
> > clone(..., CLONE_NEWNS, ...)
> >
> > After that subsequent namespace operations will only affect your process
> > and it's child processes.
> 
> Cool.
> 
> Question: if those processes mount something and then exit, does that 
> something get unmounted automatically or is this a mount point leak?

Both namespaces and vfsmounts are refcounted and garbage-collected
if their useage counts hits zero, so there will be no leak.
