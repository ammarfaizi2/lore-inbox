Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSBWTPa>; Sat, 23 Feb 2002 14:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293189AbSBWTPK>; Sat, 23 Feb 2002 14:15:10 -0500
Received: from dial-up-2.energonet.ru ([195.16.109.101]:31360 "EHLO
	dial-up-2.energonet.ru") by vger.kernel.org with ESMTP
	id <S293181AbSBWTPA>; Sat, 23 Feb 2002 14:15:00 -0500
Date: Sat, 23 Feb 2002 22:15:35 +0000 (GMT)
From: ertzog <ertzog@bk.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5 not compilling
Message-ID: <Pine.LNX.4.21.0202232212120.19912-100000@dial-up-2.energonet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just detected a second problem, while compilling 2.5.5
My parameters You can get several messages back (it is lazy for me to put
them again)

The problem is in fs/filesystems.c while
__MOD_INC_USE_COUNT(nfsd_linkage->owner);
and
__MOD_DEC_USE_COUNT(nfsd_linkage->owner);

The gcc tells, that there is a pointer to incomplete type
and it refuses to compile it.
The problem cures, with compilling in NFS server support,
because all the code of this file is just got out due the #if directive.
Can anybody solve this problem?


Best regards.

