Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVLCFe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVLCFe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 00:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLCFe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 00:34:28 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:55991 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751179AbVLCFe1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 00:34:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eXTGvVTvNy2AG862N8kAQCIbmQLsVMfeUnjXFM1yyx/PKlOq2nk6WhVTKo1GCuObZZNcuJHEyr/U7+ExjYypdyn9r3Dz+j4G13xDcEITT/Cl5yrzdXFn0Bui6mFL8/LJJqTnCPknBFTXp/wEnCf0L9UUHCkGZ4JLC2SkZPODLY0=
Message-ID: <e1e1d5f40512022134y73318ed4p54064a07905cef3c@mail.gmail.com>
Date: Fri, 2 Dec 2005 21:34:26 -0800
From: Daniel Bonekeeper <thehazard@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel loading question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this probably should not be posted here, but who knows ? =)

Well, on arch/i386/boot/compressed/head.S line 65 we call
decompress_kernel that decompresses the kernel starting at $0x100000.
If we were loaded high, we first move the code back to $0x1000 before
ljmp'ing it.

My question is: why, when loaded high, we care to disable interrupts
(cli  # make sure we don't get interrupted) while otherwise, we don't
do that ? in both cases, aren't we supposed to disable cli (as they
can happen in both situations) ?

Since currently, the kernel boots fine for everybody in the world, I
know that this is not a bug... but why don't disable interruptions on
both cases ?

Thanks !

--
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
