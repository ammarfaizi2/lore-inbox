Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTEGULP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbTEGULO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:11:14 -0400
Received: from webmail.hamiltonfunding.la ([12.162.17.40]:17458 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264289AbTEGULM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:11:12 -0400
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<20030507135657.GC18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305071008080.11871@chaos>
	<p05210601badeeb31916c@[207.213.214.37]>
	<Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
	<Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>
	<Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com>
	<Pine.LNX.4.53.0305071547060.13869@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 07 May 2003 13:23:43 -0700
In-Reply-To: <Pine.LNX.4.53.0305071547060.13869@chaos>
Message-ID: <52issmo69c.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 May 2003 20:23:46.0202 (UTC) FILETIME=[8FA507A0:01C314D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    [ misinformation snipped ]

OK, my real last word on the subject.

When the kernel is running on behalf of a user process, there is more
context than just the struct task_struct part of current.  There is a
kernel stack, which must be per process since each process can have
its own call chain of kernel functions.

By all means, see switch_to().  Look at what it does to ESP.

 - Roland
