Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUCJUw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUCJUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:52:56 -0500
Received: from main.gmane.org ([80.91.224.249]:33514 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262827AbUCJUvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:51:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: how to detect udp packets drops ?
Date: Wed, 10 Mar 2004 21:51:44 +0100
Message-ID: <yw1xy8q8xw67.fsf@kth.se>
References: <404E36F1.8000908@newsguy.com> <404F6F52.2000202@cs.princeton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-2480.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:zRW8RG6Sz/q2BMG3nurVpeV07+U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KyoungSoo Park <kyoungso@cs.princeton.edu> writes:

> Hi,
>
> I'm not sure if my question is appropriate, but is there any way to
> directly detect UDP packet drops in linux 2.4.x ?  I'd like to know
> how many UDP packets get actually dropped by the kernel for the
> overloaded time period.  Any suggestions?

The thing about UDP is that you can't tell if the packet got through,
that's what unreliable means.  However, if you just want to test a
link you could send a stream of packets with known data in them, such
as an increasing number sequence.  The receiving end will then be able
to tell if there were any drops.  Remember that out of order delivery
is allowed for UDP, so you might want to check for that too.

-- 
Måns Rullgård
mru@kth.se

