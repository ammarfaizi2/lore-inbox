Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSEDBzD>; Fri, 3 May 2002 21:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315761AbSEDBzC>; Fri, 3 May 2002 21:55:02 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:57379 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S315760AbSEDBzC>; Fri, 3 May 2002 21:55:02 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A781780F8@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, "'ak@muc.de'" <ak@muc.de>
Subject: RE: my slab cache broken on sparc64
Date: Fri, 3 May 2002 20:54:42 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>get_user() MUST be used only on "user pointers", it is being
>used on a kernel pointer here.
>
>It would work if the access was surrounded by:
>
>	old_fs = get_fs();
>	set_fs(KERNEL_DS);
>	... get_user(kernel_pointer) ...
>	set_fs (old_fs);
>
>But it is not.

Ok, now I see it.   I'll change mine and try that out, though Andi Kleen
indicated he would fix it for real.  :o)

Thanks, Wow, two e-mails and a fix, that's got to be some kind of record
:o)
Bruce H.
