Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRDCUIQ>; Tue, 3 Apr 2001 16:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbRDCUIF>; Tue, 3 Apr 2001 16:08:05 -0400
Received: from fungus.teststation.com ([212.32.186.211]:62892 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S132643AbRDCUHz>; Tue, 3 Apr 2001 16:07:55 -0400
Date: Tue, 3 Apr 2001 22:06:53 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] smbfs: caching problems
In-Reply-To: <3AC68228.E9D8161B@baldauf.org>
Message-ID: <Pine.LNX.4.30.0104032110440.12861-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Xuan Baldauf wrote:

> Hello,
> 
> there is something wrong with smbfs caching which makes my
> applications fail. The behaviour happens with
> linux-2.4.3-pre4 and linux-2.4.3-final.

Any version you know it doesn't happen with? (including 2.2 versions)


> Consider following shell script: (where /mnt/n is a
> smbmounted smb share from a Win98SE box)

Reproducible, but so far only with win98 (SE?). NT4, samba are testing ok
with the sizes I have tried, not sure what that means.

Thanks a lot for providing a testcase.


I have started looking but right now a lot of non-linux things are calling
for attention. If it isn't trivial I may need some time to get around to
it.
(insanely early morning flights to Stockholm and late evening return
 flights, work, easter holiday preparations, local community stuff ... and
 that was just today.
 Sorry, I'm tired and felt like complaining to someone.
 Pay no attention to me :)

You may want to consider looking into it yourself, if you need it
fixed quickly.

'tail -f' has previously been depending on smb_revalidate_inode to update
inode information properly (I suspect that one right now, will check
tomorrow. Possibly that smb open/close changes modification times ...
and/or some win95 bug workaround is causing this?)

Enabling verbose debug (select parts perhaps) can be useful.
Adding debug printouts on inode mtime+size.

/Urban

