Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbUKJREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUKJREv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbUKJREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:04:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:2223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262012AbUKJREl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:04:41 -0500
Date: Wed, 10 Nov 2004 09:04:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dinakar Guniguntala <dino@in.ibm.com>
cc: Sripathi Kodi <sripathik@in.ibm.com>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
In-Reply-To: <20041110143518.GC4502@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0411100903290.2301@ppc970.osdl.org>
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
 <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411080820110.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411081708000.2301@ppc970.osdl.org> <20041109143118.GA8961@in.ibm.com>
 <Pine.LNX.4.58.0411090745250.2301@ppc970.osdl.org> <20041110143518.GC4502@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Nov 2004, Dinakar Guniguntala wrote:
> 
> How about if we set the flag only in the cases when the exit state is not
> either TASK_DEAD or TASK_ZOMBIE. 

Why TASK_DEAD? We can't reap such a process anyway, no? But yes, I agree 
with the approach.

		Linus
