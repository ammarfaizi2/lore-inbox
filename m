Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUD0XKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUD0XKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUD0XKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:10:50 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:9405 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264297AbUD0XKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:10:49 -0400
Date: Wed, 28 Apr 2004 08:58:11 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: "Pavel Machek" <pavel@suse.cz>, "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Andrew Morton" <akpm@zip.com.au>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Cc: seife@suse.de, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Nigel Cunningham" <ncunningham@linuxmail.com>,
       "Roland Stigge" <stigge@antcom.de>, 234976@bugs.debian.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.org
References: <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au> <20040427124837.GK10593@elf.ucw.cz> <20040427125402.GA16740@gondor.apana.org.au> <20040427215236.GA469@elf.ucw.cz>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr640q9abshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <20040427215236.GA469@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel et al.

On Tue, 27 Apr 2004 23:52:36 +0200, Pavel Machek <pavel@suse.cz> wrote:

> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +	{
> +		extern char swsusp_pg_dir[PAGE_SIZE];
> +		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
> +	}
> +#endif

Would you consider making that #ifdef CONFIG_PM, so that I could use it  
too without needing to patch it further? (I'm using  
CONFIG_SOFTWARE_SUSPEND2 if you prefer something more specific).

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
