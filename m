Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTEJVdM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTEJVdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:33:11 -0400
Received: from corky.net ([212.150.53.130]:45718 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S264514AbTEJVdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:33:11 -0400
Date: Sun, 11 May 2003 00:45:44 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: daw@mozart.cs.berkeley.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.LNX.4.44.0305110036140.17881-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's see you do sys_execve()...  sys_socketcall() and sys_ioctl() are
> fun, too.  (And, I worry about doubly-indirected pointers, for instance.)
> It's probably do-able, but you'd better stock up on the Advil in advance:
> we're in major headache country, folks.

I agree.  I could post my 2.0.x code for doing this, but it would be
counter-productive since security apps should use LSM for this very
reason.  I was merely suggesting a way for Masud to solve his specific
problem without rewriting his module.

sys_execve() and sys_socketcall() are actually not that hard.  sys_ioctl()
is next to impossible because no never know what the structs look like.
Luckily, most security apps don't require ioctl-screening.

Most security applications should use LSM but its not a good reason to
remove sys_call_table, since its still useful for many non-security
purposes.

	Yoav Weiss

