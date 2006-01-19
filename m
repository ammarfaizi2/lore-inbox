Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161448AbWASVza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161448AbWASVza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161450AbWASVza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:55:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161448AbWASVz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:55:29 -0500
Date: Thu, 19 Jan 2006 13:56:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: pageattr remove __put_page
Message-Id: <20060119135646.7512415e.akpm@osdl.org>
In-Reply-To: <20060119141300.GE958@wotan.suse.de>
References: <20060117150356.7421.27313.sendpatchset@linux.site>
	<20060118190028.7047ade2.akpm@osdl.org>
	<20060119141300.GE958@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> > Or we just forget about page_private() and go back to using page->private -
> > page_private() was rather a stopgap thing.
> > 
> 
> Could we? We can do anonymous unions now, right?

Yes, that code's merged up now - we're using anonymous-struct in
anonymous-union and page->private had its leading underscore taken away.

But we should be consistent..
