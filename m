Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSEVLuD>; Wed, 22 May 2002 07:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEVLuC>; Wed, 22 May 2002 07:50:02 -0400
Received: from alfie.demon.co.uk ([158.152.44.128]:3846 "HELO
	bagpuss.pyrites.org.uk") by vger.kernel.org with SMTP
	id <S311885AbSEVLuB>; Wed, 22 May 2002 07:50:01 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Linux-2.5.17
Date: 22 May 2002 12:49:59 +0100
Organization: Alfie's Internet Node
Message-ID: <acg0l7$klk$1@alfie.demon.co.uk>
In-Reply-To: <86256BC1.001146A6.00@smtpnotes.altec.com>
X-Newsreader: NN version 6.5.0 CURRENT #120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <86256BC1.001146A6.00@smtpnotes.altec.com> Wayne.Brown@altec.com writes:
> I can live with not building, crashing, or even eating filesystems.  Those
> things will be fixed sooner or later.  But breaking userspace programs -- that
> may well be permanent.

Looking at the source code to libgtop-1.0.6 (the version I have
easy access to), the parser used to extract the swap information from
/proc/meminfo is extremely fragile (read: broken).  Rather than looking
at the tag at the start of each line for the one it requires, it assumes
that the "Swap:" details are on the 3rd line (and doesn't even verify
the label).

You can't expect the kernel to keep compatability for such poor user-space
code (especially during a development cycle).

The change to /proc/meminfo came about in 2.5.1, and this removed
the first two lines from the old, inflexible layout (that has been
deprecated for a while, and should probably been removed during the
2.1.x development cycle).

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
