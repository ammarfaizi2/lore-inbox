Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270857AbTGVOVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTGVOVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:21:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29457 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270857AbTGVOVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:21:10 -0400
Date: Tue, 22 Jul 2003 16:36:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing file .
Message-ID: <20030722143613.GA1150@mars.ravnborg.org>
Mail-Followup-To: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <F341E03C8ED6D311805E00902761278C0D2A2BE2@xfc04.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F341E03C8ED6D311805E00902761278C0D2A2BE2@xfc04.fc.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Failed with the following:
>    kernel/profile.c:11:26: asm/sections.h:  No such file or directory
>    kernel/profile.c: In function `profile_init':
>    kernel/profile.c:38: `_etext' undeclared (first use in this function)
>    kernel/profile.c:38: (Each undeclared identifier is reported only once
>    kernel/profile.c:38: for each function it appears in.)
>    kernel/profile.c:38: `_stext' undeclared (first use in this function)
>    make[1]: *** [kernel/profile.o] Error 1
>    make: *** [kernel] Error 2

cp include/asm-i386/sections.h include/asm-ia64/sections.h
should do the trick.

	Sam
