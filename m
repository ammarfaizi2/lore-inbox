Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUCPKhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUCPKhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:37:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:52432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262756AbUCPKhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:37:14 -0500
Date: Tue, 16 Mar 2004 02:37:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark de Vries <mark@asphyx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buffer layer error at fs/buffer.c:430
Message-Id: <20040316023713.26aee705.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403160749100.32629@fgvyrggb>
References: <Pine.LNX.4.58.0403160749100.32629@fgvyrggb>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark de Vries <mark@asphyx.net> wrote:
>
> Mar 15 18:10:14 article kernel: buffer layer error at fs/buffer.c:430
> ...
>  Mar 15 18:10:14 article kernel: block=8192, b_blocknr=18446744073709551615
>  Mar 15 18:10:14 article kernel: b_state=0x00000000, b_size=1024

This is an infuriating thing.  Do you actually have any 1k blocksize
filesystems in that machine?

You can use

	dumpe2fs -h /dev/hda1 | grep 'Block size'

to tell.
