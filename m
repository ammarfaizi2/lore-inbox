Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264897AbSKEFxM>; Tue, 5 Nov 2002 00:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSKEFxM>; Tue, 5 Nov 2002 00:53:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52133 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264897AbSKEFxL>;
	Tue, 5 Nov 2002 00:53:11 -0500
Date: Tue, 5 Nov 2002 00:59:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: andersen@codepoet.org, Werner Almesberger <wa@almesberger.net>,
       jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
In-Reply-To: <3838354491.1036446246@[10.10.2.3]>
Message-ID: <Pine.GSO.4.21.0211050056170.2336-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Nov 2002, Martin J. Bligh wrote:

> >     I do dislike /dev/ps mightily.
> 
> Well it can't be any worse than the current crap. At least it'd 
> stand a chance in hell of scaling a little bit. So I took a very 
> quick look ... what syscalls are you reduced to per pid, one ioctl 
> and one read?

Oh, yes it can.  Easily.
	* device is not network-transparent - even in principle
	* restricting data access would be harder - welcome to suid or
sgid country
	* real killer: you think Albert would fail to produce equally
crappy code and equally crappy behaviour?  Yeah, right.

