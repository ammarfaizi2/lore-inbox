Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270865AbTGVO0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270864AbTGVO0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:26:18 -0400
Received: from palrel12.hp.com ([156.153.255.237]:37327 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S270865AbTGVO0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:26:14 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0D2A2BE3@xfc04.fc.hp.com>
From: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing 
	file .
Date: Tue, 22 Jul 2003 07:41:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sam.  Shouldn't the Makefile take care of this?

Dennis E. Miyoshi, PE
Hendrix Release Manager
Hewlett-Packard Company
825 14th Street, S.W.,  MS E-200
Loveland, CO  80537
(970) 898-6110


-----Original Message-----
From: Sam Ravnborg [mailto:sam@ravnborg.org] 
Sent: Tuesday, July 22, 2003 8:36 AM
To: MIYOSHI,DENNIS (HP-Loveland,ex1)
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing
file .


> Failed with the following:
>    kernel/profile.c:11:26: asm/sections.h:  No such file or directory
>    kernel/profile.c: In function `profile_init':
>    kernel/profile.c:38: `_etext' undeclared (first use in this function)
>    kernel/profile.c:38: (Each undeclared identifier is reported only once
>    kernel/profile.c:38: for each function it appears in.)
>    kernel/profile.c:38: `_stext' undeclared (first use in this function)
>    make[1]: *** [kernel/profile.o] Error 1
>    make: *** [kernel] Error 2

cp include/asm-i386/sections.h include/asm-ia64/sections.h should do the
trick.

	Sam
