Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJILaG>; Tue, 9 Oct 2001 07:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275346AbRJIL34>; Tue, 9 Oct 2001 07:29:56 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:4107 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275270AbRJIL3n>;
	Tue, 9 Oct 2001 07:29:43 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change name of rep_nop 
In-Reply-To: Your message of "Tue, 09 Oct 2001 12:33:56 +0200."
             <20011009103356.4478@smtp.adsl.oleane.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 21:30:02 +1000
Message-ID: <30619.1002627002@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 12:33:56 +0200, 
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>One approach we take on PPC that you may or may not like for this is
>dynamic patching.

BIG RED WARNING: Anybody thinking of using dynamic patching must
consider modules as well as the kernel.  modutils 2.4.8 added support
for ppc archdata to allow dynamic patching of modules using the ftr
data.  There also has to be code in kernel/module.c::module_arch_init()
to take the archdata and do whatever is required.

If anybody starts doing dynamic patching, please let me know so I can
handle modutils and module_arch_init().

