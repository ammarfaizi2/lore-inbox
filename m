Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEEMoj>; Sun, 5 May 2002 08:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311829AbSEEMoi>; Sun, 5 May 2002 08:44:38 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:39457 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S311710AbSEEMoi>; Sun, 5 May 2002 08:44:38 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A7586@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        "'zippel@linux-m68k.org'" <zippel@linux-m68k.org>
Subject: RE: my slab cache broken on sparc64
Date: Sun, 5 May 2002 07:44:24 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Do it like this instead.
>
>	int fault;
>	mm_segment_t old_fs;
>
>	...
>
>	old_fs = get_fs();
>	set_fs(KERNEL_DS);
>	fault = __get_user(tmp, pc->name);
>	set_fs(old_fs);
>
>	if (fault) {
>	...

Hmm.  Just got back to this, and I thought I had taken that into account and
left all the important parts out of a loop, or if, context.  I'll look at
what I DID do, though, and maybe I'll file that last patch under my things
you shouldn't do while half asleep folder...

Thanks
Bruce H.
