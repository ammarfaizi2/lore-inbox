Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312039AbSCQOcD>; Sun, 17 Mar 2002 09:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312041AbSCQObn>; Sun, 17 Mar 2002 09:31:43 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:5837 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S312039AbSCQObd>; Sun, 17 Mar 2002 09:31:33 -0500
Date: Sun, 17 Mar 2002 15:31:27 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: fadvise syscall?
In-Reply-To: <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
Message-Id: <Pine.LNX.4.44.0203171505280.27987-100000@phobos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Anton Altaparmakov wrote:

> All of what you are asking for exists in Windows and all the semantics are
> implemented through a very powerful open(2) equivalent. I don't see why we
> shouldn't do the same. It makes more sense to me than inventing yet another
> system call...

It is easier for application writers to code:

[...]
#ifdef HAVE_FADVISE
	(void)fadvise(fd, FADV_STREAMING);
#endif
[...]

Than to have a forest of #ifdefs to determine which O_* flags are
supported. After all, we still want our programs to run under Solaris. :-)

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: 040E B5F7 84F1 4FBC CEAD  ADC6 18A0 CC8D 5706 A4B4
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

