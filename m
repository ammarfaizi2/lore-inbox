Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVB0RVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVB0RVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVB0RVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:21:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31198 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261443AbVB0RVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:21:15 -0500
Date: Sun, 27 Feb 2005 12:21:05 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: stone_wang@sohu.com
cc: akpm@osdl.org, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.6.11-rc5: kernel/sys.c setrlimit() RLIMIT_RSS
 cleanup
In-Reply-To: <17855236.1109499454066.JavaMail.postfix@mx20.mail.sohu.com>
Message-ID: <Pine.LNX.4.61.0502271220210.19979@chimarrao.boston.redhat.com>
References: <17855236.1109499454066.JavaMail.postfix@mx20.mail.sohu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005 stone_wang@sohu.com wrote:

> ulimit dont enforce RLIMIT_RSS now,while sys_setrlimit() pretend 
> it(RLIMIT_RSS) is enforced.
> 
> This may cause confusion to users, and may lead to un-guaranteed 
> dependence on "ulimit -m" to limit users/applications.
> 
> The patch fixed the problem. 

Some kernels do enforce the RSS rlimit.  Your patch could break
systems that have the RSS rlimit in their configuration files
because they used to run a kernel that enforces the RSS rlimit.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
