Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVAEJfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVAEJfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVAEJfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:35:11 -0500
Received: from ns.suse.de ([195.135.220.2]:26755 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262298AbVAEJfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:35:05 -0500
Date: Wed, 5 Jan 2005 10:34:57 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] request_irq: avoid slash in proc directory entries
Message-ID: <20050105093457.GA8684@suse.de>
References: <20050105075357.GA12473@suse.de> <20050105000129.63478670.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050105000129.63478670.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 05, Andrew Morton wrote:

> Olaf Hering <olh@suse.de> wrote:
> >
> > A few users of request_irq pass a string with '/'.
> >  As a result, ls -l /proc/irq/*/* will fail to list these entries.
> 
> hrm, interesting.  So how do these entries appear in /proc?  Do they
> actually have slashes in them?

Yes, ls /proc/irq/*/* works, but ls -l does not because you have to
stat() the entry. I havent looked in detail, just poked around in /proc.

> I get the feeling that something somewhere should be detecting this and
> should be propagating an error back.

Yeah, a quick sanity check for procfile creation would be a good thing.
