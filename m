Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUD0XQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUD0XQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUD0XQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:16:47 -0400
Received: from gprs214-174.eurotel.cz ([160.218.214.174]:54912 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264397AbUD0XQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:16:46 -0400
Date: Wed, 28 Apr 2004 01:16:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@zip.com.au>,
       seife@suse.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427231626.GA32689@elf.ucw.cz>
References: <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au> <20040427124837.GK10593@elf.ucw.cz> <20040427125402.GA16740@gondor.apana.org.au> <20040427215236.GA469@elf.ucw.cz> <opr640q9abshwjtr@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr640q9abshwjtr@laptop-linux.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, 27 Apr 2004 23:52:36 +0200, Pavel Machek <pavel@suse.cz> wrote:
> 
> >+#ifdef CONFIG_SOFTWARE_SUSPEND
> >+	{
> >+		extern char swsusp_pg_dir[PAGE_SIZE];
> >+		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
> >+	}
> >+#endif
> 
> Would you consider making that #ifdef CONFIG_PM, so that I could use it  
> too without needing to patch it further? (I'm using  
> CONFIG_SOFTWARE_SUSPEND2 if you prefer something more specific).
> 

Well, swsusp_pg_dir is defined in kernel/power/cpu.c, so it is not as
easy as defining it CONFIG_PM.

What about make CONFIG_SOFTWARE_SUSPEND2 defining
CONFIG_SOFTWARE_SUSPEND, too? We want the merged, anyway...

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
