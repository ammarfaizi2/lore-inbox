Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbTEGSAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTEGSAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:00:25 -0400
Received: from webmail.netapps.org ([12.162.17.40]:60196 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264122AbTEGR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:59:56 -0400
To: root@chaos.analogic.com
Cc: Jonathan Lundell <linux@lundell-bros.com>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<20030507135657.GC18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305071008080.11871@chaos>
	<p05210601badeeb31916c@[207.213.214.37]>
	<Pine.LNX.4.53.0305071323100.13049@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 07 May 2003 11:12:25 -0700
In-Reply-To: <Pine.LNX.4.53.0305071323100.13049@chaos>
Message-ID: <52k7d2pqwm.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 May 2003 18:12:28.0217 (UTC) FILETIME=[37FFEA90:01C314C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> The kernel stack, at least for ix86, is only one, set
    Richard> upon startup at 8192 bytes above a label called
    Richard> init_task_unit. The kernel must have a separate stack
    Richard> and, contrary to what I've been reading on this list, it
    Richard> can't have more kernel stacks than CPUs and, I don't see
    Richard> a separate stack allocated for different CPUs.

This is total nonsense.  Please don't confuse matters by spreading
misinformation like this.  Every task has a separate (8K) kernel
stack.  Look at the implementation of do_fork() and in particular
alloc_task_struct().

If there were only one kernel stack, what do you think would happen if
a process went to sleep in kernel code?

 - Roland
