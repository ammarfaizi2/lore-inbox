Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVATMmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVATMmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVATMmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:42:35 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:1966 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262137AbVATMmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:42:33 -0500
Subject: Re: [patch] Job - inescapable job containers
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: =?UTF-8?Q?=E2=80=ABLimin?= Gu <limin@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, lkml <linux-kernel@vger.kernel.org>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Philip Mucci <mucci@cs.utk.edu>
In-Reply-To: <1106213319.17195.96.camel@frecb000711.frec.bull.fr>
References: <1106213319.17195.96.camel@frecb000711.frec.bull.fr>
Date: Thu, 20 Jan 2005 13:42:26 +0100
Message-Id: <1106224946.10947.131.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/01/2005 13:50:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/01/2005 13:50:46,
	Serialize complete at 20/01/2005 13:50:46
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 10:28 +0100, Guillaume Thouvenin wrote:
>    The only thing I need to manage "jobs" is a hook in the
> do_fork() routine, everything else is done outside the kernel.

I have a question about this kind of hooks. 

It seems that if someone needs a hook somewhere in the kernel he adds
his own hook. For example we have the LSM hooks. But if someone, like
me, need to use such hooks for something that is not specific to
security, LSM is not the right framework and then, I can not use such
hooks. So, there is PAGG that offers hooks and is the right framework.
But there is some other applications, like LTT or whatever, that will
need new hooks. Isn't there a duplicate usage of hooks? Will it be
interesting for Linux to provide some generic hooks because it seems
that some (like in do_fork(), do_exit(), ... ) are often needed by
applications instead of doing the job for security, accounting,
tracing, ...

Guillaume  

