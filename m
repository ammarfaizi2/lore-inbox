Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbULWMAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbULWMAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbULWMAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:00:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1666 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261203AbULWMAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:00:01 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [Fastboot] Yet another crash dump tool
References: <20041014074718.26E6.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Dec 2004 04:59:03 -0700
In-Reply-To: <20041014074718.26E6.ODA@valinux.co.jp>
Message-ID: <m1sm5xusxk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hello,
> 
> We released a crash dump tool called "mini kernel dump".
> 
> Please see the following URL to get the motivation and the
> overview of the mini kernel dump.
> http://mkdump.sourceforge.net/
> 
> http://sourceforge.net/projects/mkdump/

While the exact details differ this seems to be strategically
the same thing as kexec crash based dumps, which are also being
developed right now.  Would you be willing to work on the kexec system
call so we can get a infrastructure that reliably does what is needed
for everyone? 

Reading your documentation it seems to indicate that you have
successfully avoid using any memory that the crashing kernel used.
Is that correct?

And just for a little active feedback.  While you safely tuck
your kernel away in your reserved area of memory it does not appear
you tuck away the data structures necessary to get there.  Which
makes me just a little nervous.

Eric
