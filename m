Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVGXUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVGXUIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGXUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 16:08:04 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:44749 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261216AbVGXUIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 16:08:01 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: xor as a lazy comparison
Date: Mon, 25 Jul 2005 06:07:50 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 18:40:25 +0200 (MEST), Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
>I have seen this in kernel/signal.c:check_kill_permission()
>
>            && (current->euid ^ t->suid) && (current->euid ^ t->uid)
>
>If current->euid and t->suid are the same, the xor returns 0, so these 
>statements are effectively the same as a !=
>
>	current->euid != t->suid ...
>
>Why ^ ?
To confuse you, coders with assembly or hardware background throw in 
equivalent bit operations to succinctly describe their visualisation 
of solution space...  Perhaps the writer _wanted_ you to pause and 
think?  Maybe the compiler produces better code?  Try it and see.

Grant.

