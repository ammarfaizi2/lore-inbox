Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQKPXGf>; Thu, 16 Nov 2000 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbQKPXGZ>; Thu, 16 Nov 2000 18:06:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129632AbQKPXGV>; Thu, 16 Nov 2000 18:06:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
Date: 16 Nov 2000 14:35:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v1ng9$omi$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0011161317120.13047-100000@weyl.math.psu.edu> <4.3.2.7.2.20001116161327.00b2f810@postoffice.brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4.3.2.7.2.20001116161327.00b2f810@postoffice.brown.edu>
By author:    David Feuer <David_Feuer@brown.edu>
In newsgroup: linux.dev.kernel
> 
> . and foo/. are also links, not directories... the directories themselves 
> are filesystem internal objects, and not discussed by the standard.  I 
> didn't know that linux supported hard links to directories... Isn't that 
> just asking for trouble?
> 

It is on filesystems which has ".." physically on disk.  Linux no
longer requires this, although for example ext2 does have this.

I don't believe it's inherently impossible in Linux anymore.  In fact,
vfsbinds provide a lot of the same kind of functionality; the main
difference between vfsbinds and hard links are that the former (a) can
cross filesystem boundaries and (b) aren't persistent.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
