Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264406AbUD0Xpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbUD0Xpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbUD0Xpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:45:30 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:34948 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264406AbUD0XoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:44:19 -0400
Date: Wed, 28 Apr 2004 09:30:08 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Cc: "Pavel Machek" <pavel@suse.cz>, "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Andrew Morton" <akpm@zip.com.au>, seife@suse.de,
       "Nigel Cunningham" <ncunningham@linuxmail.com>,
       "Roland Stigge" <stigge@antcom.de>, 234976@bugs.debian.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.org
References: <20040426104015.GA5772@gondor.apana.org.au>  <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>  <20040426131152.GN2595@openzaurus.ucw.cz>  <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz>  <20040427102344.GA24313@gondor.apana.org.au>  <20040427124837.GK10593@elf.ucw.cz>  <20040427125402.GA16740@gondor.apana.org.au>  <20040427215236.GA469@elf.ucw.cz>  <opr640q9abshwjtr@laptop-linux.wpcb.org.au>  <20040427231626.GA32689@elf.ucw.cz>  <opr641k5m2shwjtr@laptop-linux.wpcb.org.au> <1083108250.16475.54.camel@gaston>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr6418icrshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <1083108250.16475.54.camel@gaston>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 28 Apr 2004 09:24:11 +1000, Benjamin Herrenschmidt  
<benh@kernel.crashing.org> wrote:
> Which, as I keep saying, is plain broken ... You simply cannot control
> what side effects the compiler will generate, like touching the stack,
> etc... Such a critical routine _has_ to be written in assembly (and
> properly commented of course). Anything else is asking for trouble.

No, it doesn't have to be written in assembly. If that was the case, I  
wouldn't have managed to get it working under a variety of compiler  
versions already. So long as assemblers honour the directives, we're okay.  
Of course I'll freely admit that hand coding would probably result in  
nicer, tidier and maybe faster code, and you would know that it was doing  
the right thing. In the long time I would prefer to do that. But right now  
I'm being a pragmatist: .c works, I don't know x86 assembly and don't have  
the time to learn it and the code is still changing a little, so I'll  
delay making a .S file for now.

Please, forgive me!

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
