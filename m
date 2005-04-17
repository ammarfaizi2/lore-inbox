Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVDQQXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVDQQXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 12:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVDQQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 12:23:11 -0400
Received: from smtpout.mac.com ([17.250.248.86]:9669 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261350AbVDQQXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 12:23:07 -0400
In-Reply-To: <4ae3c140504170912b36e9b1@mail.gmail.com>
References: <4ae3c14050417085473bd365f@mail.gmail.com> <20050417160306.GB777@alpha.home.local> <4ae3c140504170912b36e9b1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <efa44afd521dbc92f406cbbfd18ae9bd@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Why Ext2/3 needs immutable attribute?
Date: Sun, 17 Apr 2005 12:23:02 -0400
To: Xin Zhao <uszhaoxin@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2005, at 12:12, Xin Zhao wrote:
> Thanks for your reply.
>
> Yes. I know,  with immutable,  even root cannot modify sensitive
> files. What I am curious is if an intruder has root access, he may
> have many ways to turn off the immutable protection and modify files.
> So immutable is designed just to prevent a valid root from making
> silly mistakes?
>
> Xin

But without the proper capability, root _can't_ change the immutable
bit.  Of course, that also applies to DAC checks too.  Personally, I
find the immutable bit most useful at preventing accidents.  I have
several scripts designed specifically to access the same file, and I
want to prevent one of my admins from accidentally editing that file
by hand.  The best way is with a big comment in the file itself and
the immutable bit.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


