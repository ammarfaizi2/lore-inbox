Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTKJQgU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTKJQgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:36:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:43400 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263984AbTKJQgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:36:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 08:35:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: syscall numbers larger than 255?
In-Reply-To: <3FAFB081.3090900@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0311100832290.1821-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Chris Friesen wrote:

> 
> Just a quick and simple question for someone that knows the answer.
> 
> Stock 2.4.20 for i386 uses syscalls up to 252.  I want to add about a 
> half-dozen new syscalls (forward porting stuff that we've got on 2.4.18).
> 
> Does x86 support syscall numbers > 255?  If yes, do I have to do 
> anything special to use them? If not, what are my options?

Currently there's a discrepancy between include/asm-i386/unistd.h and 
arch/i386/kernel/entry.S. While the first define function numbers up to 
252, the entry.S file fill up the table up to 258 (epoll crosses the 255 
boundary :).



- Davide


