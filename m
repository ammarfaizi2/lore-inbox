Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVHPNf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVHPNf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVHPNf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:35:57 -0400
Received: from [81.2.110.250] ([81.2.110.250]:56039 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965223AbVHPNf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:35:56 -0400
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kern Sibbald <kern@sibbald.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508161519.39719.kern@sibbald.com>
References: <200508161519.39719.kern@sibbald.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 15:03:11 +0100
Message-Id: <1124200991.17555.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 15:19 +0200, Kern Sibbald wrote:
> have written, nor does it write() anything.  When my read() is issued, I 
> expect it to block, but it immediately returns with -1 and errno set to 
> EAGAIN.  If the read() is re-issued, a CPU intensive loop results as long as 
> the other end does not read() the data written to the socket.  This is a 
> multi-threaded program, but the other threads are all blocked on something.

You are describing behaviour as expected with nonblocking set. That
suggests to me that something or someone set or inherited the nonblock
flag on that socket. Is the strange behaviour specific to the latest
kernel ?

Alan
