Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbVITR34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbVITR34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVITR34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:29:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932717AbVITR3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:29:55 -0400
Date: Tue, 20 Sep 2005 10:29:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 4/10] vfs: global namespace semaphore
Message-Id: <20050920102900.046b128f.akpm@osdl.org>
In-Reply-To: <1127202362.10061.16.camel@localhost>
References: <20050916182619.GA28474@RAM>
	<20050920065142.GH7992@ftp.linux.org.uk>
	<1127202362.10061.16.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> On Mon, 2005-09-19 at 23:51, Al Viro wrote:
> > On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> > > This patch removes the per-namespace semaphore in favor of a global
> > > semaphore.  This can have an effect on namespace scalability.
> > 
> > ... and #2 uses that semaphore...
> 
> Patch #2, uses the global semaphore.  Yes that patch  would'nt have
> compiled without patch #4, because the global semaphore got defined only
> in the patch #4.
> 

Ordinarily that doesn't matter much.  But if you're doing a `git bisect'
and you happen to land in the middle of a patch series at a point where it
doesn't compile or run, it can ruin your whole day.

