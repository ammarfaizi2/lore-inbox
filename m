Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUBFU01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBFU01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:26:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:1737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265533AbUBFU00 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:26:26 -0500
Date: Fri, 6 Feb 2004 12:27:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli@firmament.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limit hash table size
Message-Id: <20040206122752.4dc9f434.akpm@osdl.org>
In-Reply-To: <20040206202006.GA19473@firmament.fi>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
	<p73isilkm4x.fsf@verdi.suse.de>
	<20040205190904.0cacd513.akpm@osdl.org>
	<20040206202006.GA19473@firmament.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taneli Vähäkangas <taneli@firmament.fi> wrote:
>
> OTOH, I'd very much
> appreciate if the system didn't act very sluggish during updatedb.

It really helps if your filesystems were laid out by a 2.6 kernel.  What
usually happens at present is that you install the distro using a 2.4
kernel and then install 2.6.  So all those files under /usr/bin and
/usr/include and everywhere else are laid down by the 2.4 kernel.

Problem is, 2.4's ext2 and ext3 don't have the Orlov allocator, which lays
files out in a much more updatedb-friendly way.  I've seen the disk
bandwidth quadruple as updatedb switches from a 2.4-laid-out partition to a
2.6-laid-out partition.


