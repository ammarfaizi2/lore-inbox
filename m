Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUB2WVM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 17:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUB2WVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 17:21:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:448 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbUB2WVL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 17:21:11 -0500
Date: Sun, 29 Feb 2004 14:22:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: mru@kth.se (=?ISO-8859-1?B?TeVucyBSdWxsZ+VyZA==?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel unaligned acc on Alpha
Message-Id: <20040229142218.08c3d6bc.akpm@osdl.org>
In-Reply-To: <yw1xvflp1sv6.fsf@kth.se>
References: <20040229215546.065f42e9.gigerstyle@gmx.ch>
	<yw1xvflp1sv6.fsf@kth.se>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) wrote:
>
> > Hi All,
>  >
>  > I have a lot of unaligned accesses in kernel space:
>  >
>  > kernel unaligned acc    : 2191330
>  > (pc=fffffffc002557d8,va=fffffffc00256059)
>  >
>  > It seems to be located in the networking part (iptables?) from the
>  > kernel. Can someone please help me how to find the location of these
>  > uac's? I already have recompiled the kernel with debugging enabled and
>  > tried to debug it with gdb. 
> 
>  Find the matching function in System.map.

If this is 2.6, that message should be augmented to use print_symbol().

