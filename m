Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161294AbWF0Ui1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161294AbWF0Ui1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWF0Ui1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:38:27 -0400
Received: from mercury.realtime.net ([205.238.132.86]:59106 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S1161294AbWF0UiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:38:25 -0400
In-Reply-To: <44A18335.7020706@zytor.com>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <29ea762c2af4a4dc3168b6bd980bbf67@bga.com> <44A18335.7020706@zytor.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <94b77e2ebb809991a76cbc5facab6678@bga.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [klibc 00/43] klibc as a historyless patchset
Date: Tue, 27 Jun 2006 15:39:55 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.623)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 27, 2006, at 2:12 PM, H. Peter Anvin wrote:

> Milton Miller wrote:
>>> 12-enable-config-klibc-zlib-now-required-to-build-kinit.patch
>> What does this do?  No Help, no description, and doesn't do anything
>> in the curreent patch
>
> usr/klibc/Kbuild:
>
> libc-$(CONFIG_KLIBC_ZLIB)    += \
>         zlib/adler32.o zlib/compress.o zlib/crc32.o zlib/gzio.o \
>         zlib/uncompr.o zlib/deflate.o zlib/trees.o zlib/zutil.o \
>         zlib/inflate.o zlib/infback.o zlib/inftrees.o zlib/inffast.o
>
> At this point, this is required by kinit, which is why it is not 
> possible to disable.

But that file is in 19-, so at this point in the sequence it still
does nothing, and has no help.

Oh, and the files don't exist until 39, so the build breaks from
19 to 39.  If you don't want to split the makefile, put that after
39.

>
>>> 13-uml-the-klibc-architecture-is-the-underlying-architecture.patch
>>> 14-remove-in-kernel-nfsroot-code.patch
>>> 15-default-klibcarch--arch.patch
>>> 16-sparc64-transmit-arch-specific-options-to-kinit-via-arch-cmd.patch
>>> 17-sparc32-transfer-arch-specific-options-to-arch-cmd.patch
>>     where is x86 and x86_64 ?
>>     oh you deleted and did not put that back
>
> That's correct; I went around and talked to both x86 and sparc people, 
> and the x86 people uniformly announced rdev support as being obsolete; 
> the sparc people, however, continue to rely on being able to get data 
> from openprom.

Then it should be a seprate patch, and go though feature-removal or
not on its own merits.

>>> 18-klibc-inkernel-merge-s390s390x-4.patch
>>     This patchname is meaningless.
>>     The description in the patch is worse.
>>     It looks like it should be 18-s390-set-klibcarch
>> Hmm... i didn't find the patch removig usr/Makefile, just adding
>> usr/Kbuild.   usr/Kbuild should be a diff against the existing
>> usr/Makefile, whcih can be renamed.
>
> True.  Git could work this out.
>
> I have been reluctant to spend too much time on packaging, because 
> I've still had the issue of continue to maintain the out-of-tree 
> distribution (which includes usr/Kbuild) indefinitely.  I need to 
> spend some more time scripting.

Because the out-of-tree is trying to be buildable in-tree?  Or because
the out-of-tree and in-tree both need to build the same tools?

milton

