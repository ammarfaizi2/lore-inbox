Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262819AbTCRW0E>; Tue, 18 Mar 2003 17:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbTCRW0E>; Tue, 18 Mar 2003 17:26:04 -0500
Received: from palrel13.hp.com ([156.153.255.238]:57740 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id <S262819AbTCRWZ6>;
	Tue, 18 Mar 2003 17:25:58 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15991.40836.398583.695871@napali.hpl.hp.com>
Date: Tue, 18 Mar 2003 14:36:52 -0800
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       alan@redhat.com
Subject: Re: sys32_ioctl: kill code duplication
In-Reply-To: <20030315221214.GA2102@elf.ucw.cz>
References: <20030315221214.GA2102@elf.ucw.cz>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Pavel> Hi!
  Pavel> This kills code duplication in sys32_ioctl. It should work on x86-64
  Pavel> and sparc64; other architecture maintainers said that "anything that
  Pavel> moves code out of arch/*/kernel/ioctl32.c is welcome" or similar.

  Pavel> Linus, what is required to make it go in?

  Pavel> Alan, would you be willing to let this be merged through you?

I think it's a good idea to get rid of the ioctl code duplication, but
since the code involved is often subtle, I think it should be tested
on all affected architectures first (or, at least, there should be
some argument as to why the new code is no worse than the old one).

In the particular case of ia64, I'd suggest to ask on
linux-ia64@linuxia64.org for a volunteer to test the patch.

	--daivd
