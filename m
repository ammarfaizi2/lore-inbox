Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbTEFJfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTEFJfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:35:25 -0400
Received: from [217.157.19.70] ([217.157.19.70]:23567 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262479AbTEFJfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:35:24 -0400
Date: Tue, 6 May 2003 11:47:55 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
In-Reply-To: <20030506103823.B27816@infradead.org>
Message-ID: <Pine.LNX.4.40.0305061146050.8287-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Christoph Hellwig wrote:

> > In 2.4.21-rc1 some inline functions are added to asm-i386/byteorder.h.
> > When __STRICT_ANSI__ is defined, __u64 doesn't get defined by
> > asm-i386/types.h, but it is used in one of the new inline functions,
> > __arch__swab64.
> >
> > This causes files that use __STRICT_ANSI__ and include any file that
> > relies on byteorder.h to give a compile error:
>
> It's very simple, don't include kernel headers from userland..

What would you suggest as an alternative source for the constants in
linux/cdrom.h when direct CD-ROM access is required (e.g. for audio
ripping)?

In any case, if the __STRICT_ANSI__ conditional is there in types.h, it
should be there in byteorder.h as well.

// Thomas

