Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbUKWKK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUKWKK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKWKK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:10:26 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:2517 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262143AbUKWKJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:09:26 -0500
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1101200197.6210.72.camel@frecb000711.frec.bull.fr>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
	 <20041123080643.GD23974@kroah.com>
	 <1101200197.6210.72.camel@frecb000711.frec.bull.fr>
Date: Tue, 23 Nov 2004 11:09:21 +0100
Message-Id: <1101204561.6210.94.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 11:16:26,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 11:16:28,
	Serialize complete at 23/11/2004 11:16:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 09:56 +0100, Guillaume Thouvenin wrote:
> On Tue, 2004-11-23 at 00:06 -0800, Greg KH wrote:
> > On Tue, Nov 23, 2004 at 07:03:17AM +0100, Guillaume Thouvenin wrote:
> > > 
> > >    I don't know if this solution is good but it's easy to implement and
> > > it just does the trick. I made some tests and it doesn't impact the
> > > performance of the Linux kernel. 
> > 
> > What's wrong with the LSM hook already available for you to use for this
> > function?
> > 
> > thanks,
>
> Is it possible to get the parent PID and the child PID which are
> involved when the fork occurred?

I tried to use LSM and it works because "current" holds the pointer to
the parent. Thus, with fields "pid" and "children" I can have the
information.

So thank you very much for the hint,
Guillaume

