Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSHXOEU>; Sat, 24 Aug 2002 10:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHXOEU>; Sat, 24 Aug 2002 10:04:20 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:18700 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S316213AbSHXOET>; Sat, 24 Aug 2002 10:04:19 -0400
Date: Sat, 24 Aug 2002 16:08:07 +0200 (CEST)
From: Pawel Kot <pkot@echelon.pl>
X-X-Sender: <pkot@urtica.linuxnews.pl>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK-2.4 PATCH] Fix compile with highmem and highio
In-Reply-To: <E17i1gF-00034U-00@storm.christs.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0208241603390.7446-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Anton Altaparmakov wrote:

>   Remove duplicate & bogus kmap_prot and kmap_pte exports.
>   These are arch specific and only four architectures implement them. So
>   on all other orchitectures with highmem enabled compilation would fail with
>   these exports in ksyms.c...

No, only these 4 architectures allow to set HIGHMEM. So no failure here.

>   The architectures which need them already export them via their arch-ksyms files.

No. They don't. At least in 2.4.20-pre4. I think they may be exported in
your tree, because of the ntfs backport patch.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

