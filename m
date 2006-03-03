Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWCCNp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWCCNp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCCNp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:45:58 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44476 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751450AbWCCNp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:45:57 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: Re: [PATCH] adjust /dev/{kmem,mem,port} write handlers
References: <44081B03.76F0.0078.0@novell.com>
	<1141378697.2883.39.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 03 Mar 2006 14:45:41 +0100
In-Reply-To: <1141378697.2883.39.camel@laptopd505.fenrus.org>
Message-ID: <p738xrrd4l6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Fri, 2006-03-03 at 10:31 +0100, Jan Beulich wrote:
> > The /dev/mem and /dev/kmem write handlers weren't fully POSIX compliant in
> > that they wouldn't always force the file pointer to be updated when returning
> > success status.
> 
> should we instead just remove the /dev/mem and/or /dev/kmem write
> handlers entirely?

If you mmap it doesn't make any sense to not have read/write.
And they are sometimes quite useful for debugging.

-Andi
