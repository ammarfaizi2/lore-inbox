Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUK0NPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUK0NPB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 08:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUK0NPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 08:15:01 -0500
Received: from mail.zmailer.org ([62.78.96.67]:43909 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261208AbUK0NOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 08:14:42 -0500
Date: Sat, 27 Nov 2004 15:14:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: VGER had a spell of email dysfunction
Message-ID: <20041127131441.GL8704@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a while VGER did answer to all MAIL FROM and RCPT TO lines of
the SMTP protocol "450 I am sick.." (actual text was something else)
and thus refused to take any email from outside and asked for latter
retry.  (All proper MTAs have a queue, and they use it.)


It is amazing how many noticed the slow-down of the message flood,
and  asked from VGER's postmaster (or webmaster) about the thing.
Unfortunately at this time the problem prevented the question from
being delivered to us...  Linus himself knew other addresses, and
got our immediate attention.


Technically: VGER's SMTP input server's one helper program had ran
out of sockets, and it didn't do correct resource rollback in all
failure situations -> it didn't heal itself.


This had started to some extent on Wednesday morning (UTC) and it went
all bad on Thursday noonish (UTC) and finally we became aware of the
thing on Friday around 18:00 UTC, analyzed the problem, and restarted
relevant subsystem. (Restart does cure some problems, this was in that
group of things.)


Accumulated queues from all over were delivered into VGER in about
10 hours, and in about the same time they were also processed
(delivery bounces and list messages, both.)



/Matti Aarnio -- one of VGER's postmasters
