Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290901AbSASCaf>; Fri, 18 Jan 2002 21:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290904AbSASCaQ>; Fri, 18 Jan 2002 21:30:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27918 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290901AbSASCaI>; Fri, 18 Jan 2002 21:30:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rm-ing files with open file descriptors
Date: 18 Jan 2002 18:29:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2almg$vtl$1@cesium.transmeta.com>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <a2afsg$73g$2@ncc1701.cistron.net>
By author:    Miquel van Smoorenburg <miquels@cistron.nl>
In newsgroup: linux.dev.kernel
> 
> Well no. new_fd will refer to a completely new, empty file
> which has no relation to the old file at all.
> 
> There is no way to recreate a file with a nlink count of 0,
> well that is until someone adds flink(fd, newpath) to the kernel.
> 

This *might* work:

link("/proc/self/fd/40", newpath);

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
