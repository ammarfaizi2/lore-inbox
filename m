Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSFIVE2>; Sun, 9 Jun 2002 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSFIVE1>; Sun, 9 Jun 2002 17:04:27 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:59406 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315202AbSFIVE1>;
	Sun, 9 Jun 2002 17:04:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206092104.g59L4JD448386@saturn.cs.uml.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
To: thunder@ngforever.de (Thunder from the hill)
Date: Sun, 9 Jun 2002 17:04:18 -0400 (EDT)
Cc: ebiederm@xmission.com (Eric W. Biederman), davej@suse.de (Dave Jones),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <Pine.LNX.4.44.0206091257340.8715-100000@hawkeye.luckynet.adm> from "Thunder from the hill" at Jun 09, 2002 01:00:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the h writes:
> On 9 Jun 2002, Eric W. Biederman wrote:

>> #include <linux/*>
>> and 
>> #include <asm/*>
>> are no longer supported.

Try "are no longer supplied by raw kernel source" instead.
They damn well better exist, cleaned up for non-kernel use.

> Stop! The reason for _some_ includes there is actually to keep some 
> definitions in sync with the kernel, e.g. errno values! Stopping them 
> altogether is a Really Bad Thing[tm], IMO, since it means users will have 
> to get a new glibc with almost every kernel they have (don't tell me we 
> don't change much!).
>
> I'm against it.

Too late. You're WAY too late. This is on a Debian box:

$ /bin/ls -ldog /usr/include/linux
drwxr-xr-x   11 root        28672 Jun  4 19:41 /usr/include/linux

As you can see, a kernel upgrade would do nothing to
change the headers in /usr/include/linux.
