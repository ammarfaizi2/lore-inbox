Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135918AbRDZUt5>; Thu, 26 Apr 2001 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135915AbRDZUtr>; Thu, 26 Apr 2001 16:49:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:45060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135911AbRDZUta>; Thu, 26 Apr 2001 16:49:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
Date: 26 Apr 2001 13:49:05 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ca1k1$4ap$1@cesium.transmeta.com>
In-Reply-To: <3AE879AE.387D3B78@antefacto.com> <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
By author:    Bjorn Wesen <bjorn@sparta.lu.se>
In newsgroup: linux.dev.kernel
> 
> > 5. Can you set size limits on ramfs/tmpfs/memfs?
> 
> i don't think you can set a limit in the current ramfs implementation but
> it would not be particularly difficult to make it work I think
> 

It's a little more painful than you'd think for the simple reason that
ramfs currently contains no space accounting whatsoever, which
probably is a bad thing.  It definitely gave me some serious pause
when I was working on SuperRescue 1.3, since I had no way of
reasonably judging how big my ramfs actually was.  The only way I
could get a reasonable idea was rebooting with various mem=
parameters.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
