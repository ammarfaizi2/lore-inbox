Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285557AbRLGVW3>; Fri, 7 Dec 2001 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285556AbRLGVWU>; Fri, 7 Dec 2001 16:22:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285554AbRLGVWN>; Fri, 7 Dec 2001 16:22:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: On re-working the major/minor system
Date: 7 Dec 2001 13:21:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9urbtm$69e$1@cesium.transmeta.com>
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> <E16CJnv-0005c0-00@the-village.bc.nu> <20011207135100.A17683@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011207135100.A17683@codepoet.org>
By author:    Erik Andersen <andersen@codepoet.org>
In newsgroup: linux.dev.kernel
> 
> Right.  Tons of apps have illicit insider knowledge of kernel
> major/minor representation and NEED IT to do their job.  Try
> running 'ls -l' on a device node.  Wow, it prints out major and
> minor number.  You can pack up a tarball containing all of /dev
> so tar has to has insider major/minor knowledge too -- as does
> the structure of every existant tarball!  Check out, for example,
> Section 10.1.1 (page 210) of the IEEE Std. 1003.1b-1993 (POSIX)
> and you will see every tarball in existance stores 8 chars for
> the major, and 8 chars for the minor....
> 

Actually, it's not "tons of apps", it's in the C library itself.

These things are defined in <sys/sysmacros.h> and anyone who uses
anything else should be taken out and shot.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
