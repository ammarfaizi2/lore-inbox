Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWDHJGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWDHJGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 05:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWDHJGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 05:06:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:65244 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751409AbWDHJGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 05:06:41 -0400
Date: Sat, 8 Apr 2006 11:06:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: openbsd shen <openbsd.shen@gmail.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: What means "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"
In-Reply-To: <6ff3e7140604051838k1b332990i488f373aad99fa71@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604081103400.21887@yvahk01.tjqt.qr>
References: <6ff3e7140604051838k1b332990i488f373aad99fa71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: What means "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"

Does not look like x86 asm code:

>        p = (char *) memmem(code, SCLEN, "\xff\x14\x85", 3);

call dword ptr [edx-...]

>        pt = (char *) memmem(p+7, SCLEN-(p-code)-7,
>                "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8", 9);

mov dword ptr [esp+0x18], 0xffffffda


Nope, does not look meaningful if taken as x86 asm.


Jan Engelhardt
-- 
