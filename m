Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTINLOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTINLOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:14:18 -0400
Received: from strawberry.blancmange.org ([62.3.122.65]:15623 "EHLO
	strawberry.blancmange.org") by vger.kernel.org with ESMTP
	id S262364AbTINLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:14:17 -0400
Date: Sun, 14 Sep 2003 12:14:08 +0100
From: Mo McKinlay <lkml@ekto.ekol.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: logging when SIGSEGV is processed?
Message-ID: <20030914111408.GA14514@strawberry.blancmange.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found this patch for kernel 2.2 which logs a message when some process 
> receives SIGSEGV.

Why not just do it in userspace? A program which does nothing more than
spawn a child and wait for it to terminate, performing some action based on
the kind and status of exit, should be fairly trivial?

Admittedly, it might need some shoehorning into some existing setups (i.e.,
where the daemon you wish to watch isn't started directly, but by something
else), but it wouldn't be too tricky, I'd've thought.

[See wait(2), specifically the bits about how to interpret `status']

Mo.
