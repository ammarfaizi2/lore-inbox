Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSG0LiC>; Sat, 27 Jul 2002 07:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318739AbSG0LiB>; Sat, 27 Jul 2002 07:38:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9557 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318738AbSG0LiA>; Sat, 27 Jul 2002 07:38:00 -0400
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Erik Andersen <andersen@codepoet.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Header files and the kernel ABI
References: <Pine.LNX.4.44.0207251455460.17906-100000@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Jul 2002 05:29:09 -0600
In-Reply-To: <Pine.LNX.4.44.0207251455460.17906-100000@waste.org>
Message-ID: <m1adodif3u.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> writes:
> 
> The idea of maintaining them separately is that people won't be able to
> touch the ABI without explicitly going through a gatekeeper whose job is
> to minimize breakage. Linus usually catches ABI changes but not always.
> 
> I explicitly did _not_ suggest making it the job of libc maintainers. And
> the whole point of the exercise is to avoid ABI of the day anyway. The ABI
> should change less frequently than the kernel or libc. It's more analogous
> to something like modutils.

Except for ioctls.  Until we can get those under control the abi headers
need to remain part of the kernel.  Gatekeeping on the ioctls is something
we need.

And even if the code is part of the kernel, Linus can still delegate
the work of verifying it he wants.

Eric
