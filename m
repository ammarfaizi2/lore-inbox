Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136741AbREAWE0>; Tue, 1 May 2001 18:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbREAWEQ>; Tue, 1 May 2001 18:04:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11526 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136739AbREAWED>; Tue, 1 May 2001 18:04:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Maximum files per Directory
Date: 1 May 2001 15:03:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9cnbs0$uk3$1@cesium.transmeta.com>
In-Reply-To: <272800000.988750082@hades> <E14uhI2-0002NH-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E14uhI2-0002NH-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > cyrus-imapd i ran into problems.
> > At about 2^15 files the filesystem gave up, telling me that there cannot be
> > more files in a directory.
> > 
> > Is this a vfs-Issue or an ext2-issue?
> 
> Bit of both. You exceeded the max link count, and your performance would have
> been abominable too. cyrus should be using heirarchies of directories for
> very large amounts of stuff.
> 

But also showing, once again, that this particular scalability problem
really is a headache for some people.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
