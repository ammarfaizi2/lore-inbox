Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTIXN53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 09:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbTIXN53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 09:57:29 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:30445 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261180AbTIXN52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 09:57:28 -0400
Date: Wed, 24 Sep 2003 15:57:20 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
Message-ID: <20030924155720.C31236@devserv.devel.redhat.com>
References: <1064408962.5074.2.camel@laptop.fenrus.com> <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>; from raven@themaw.net on Wed, Sep 24, 2003 at 09:38:16PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 09:38:16PM +0800, Ian Kent wrote:
> > interruptible_sleep_on ?
> > 
> 
> OK so maybe I should have suggestions instead of comments.

instead of interruptible_sleep_on(), it looks like you really want
to use completions for this code..
see kernel/workqueue.c for how those are used
