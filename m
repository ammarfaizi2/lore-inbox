Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUJ1AyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUJ1AyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUJ1Awt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:52:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:36815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262614AbUJ1Att (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:49:49 -0400
Date: Wed, 27 Oct 2004 17:49:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Early call_usermodehelper causes double fault on x86_64
Message-ID: <20041027174948.L2357@build.pdx.osdl.net>
References: <20041027124055.B2357@build.pdx.osdl.net> <20041027232715.GE23595@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041027232715.GE23595@wotan.suse.de>; from ak@suse.de on Thu, Oct 28, 2004 at 01:27:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> It looks like do_execve returned with a zero return without
> executing start_thread properly. I would add a printk to 
> all error exits in the execve path and see which one triggers.

Yup, you're right.  There are no binfmts registered, so
search_binary_handler terminates and returns 0, not an
x86_64 specific problem at all.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
