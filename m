Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbUB2VYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUB2VYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:24:49 -0500
Received: from main.gmane.org ([80.91.224.249]:22967 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262141AbUB2VYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:24:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: kernel unaligned acc on Alpha
Date: Sun, 29 Feb 2004 22:24:45 +0100
Message-ID: <yw1xvflp1sv6.fsf@kth.se>
References: <20040229215546.065f42e9.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-4136.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:HAr9Yr0mkeyhfuKb8mnnjowWVzc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Giger <gigerstyle@gmx.ch> writes:

> Hi All,
>
> I have a lot of unaligned accesses in kernel space:
>
> kernel unaligned acc    : 2191330
> (pc=fffffffc002557d8,va=fffffffc00256059)
>
> It seems to be located in the networking part (iptables?) from the
> kernel. Can someone please help me how to find the location of these
> uac's? I already have recompiled the kernel with debugging enabled and
> tried to debug it with gdb. 

Find the matching function in System.map.  Look for the entry with the
highest address less than or equal to the pc value.

> Another question: What's the meaning of va?

It's the virtual memory address being accessed.  The va value is
rather close to the pc, so I would guess that it is some static data
from the same source file as the function that is being accessed.

-- 
Måns Rullgård
mru@kth.se

