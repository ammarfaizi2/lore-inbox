Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132509AbQLJBSv>; Sat, 9 Dec 2000 20:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbQLJBSl>; Sat, 9 Dec 2000 20:18:41 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:30476 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S132509AbQLJBS1>; Sat, 9 Dec 2000 20:18:27 -0500
Date: Sat, 9 Dec 2000 19:48:41 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>
Subject: SNDCTL_DSP_SETFRAGMENT broken in OSS drivers?
Message-ID: <Pine.LNX.4.30.0012091937540.8366-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using 2.4.0-test12-pre7. I have noticed that the game "Abuse" produces
only noise with the legacy YMF PCI driver but works with the native driver
(ymfpci.o).

I found that Abuse uses SNDCTL_DSP_SETFRAGMENT ioctl. When I disable this
ioctl in audio.c (which is used only by OSS drivers, such as ymf_sb), i.e.
make it return -EINVAL, Abuse works and produces correct sounds. I
understand that it uses an alternative way to output the sound.

This looks like a bug in the OSS driver (sound.o). Could anybody please
test Abuse on SoundBlaster or some other OSS driver?

Regards,
Pavel Roskin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
