Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVGLK6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVGLK6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVGLK6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:58:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32182 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261320AbVGLK6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:58:04 -0400
Date: Tue, 12 Jul 2005 12:57:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [5/48] Suspend2 2.1.9.8 for 2.6.12: 350-workthreads.patch
Message-ID: <20050712105754.GA23947@elf.ucw.cz>
References: <11206164393426@foobar.com> <112061643920@foobar.com> <20050710230441.GC513@infradead.org> <1121150400.13869.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121150400.13869.22.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Again, why do you think you need this?
> 
> 1. If something should be wrong with the freezer, it forms part of a
> safety net that stops your data on disk being trashed.

> 2. Separating out threads doing syncing from threads submitting I/O
> makes the refrigerator much more reliable, even under extreme load.

This seems to be red herring. Sometimes sync took way too long (like
hours) with older kernels and reiserfs, but I believe that has been
fixed. If not, we need to fix it, anyway; no need to work around it in
suspend2.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
