Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRK0Mfx>; Tue, 27 Nov 2001 07:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRK0Mfn>; Tue, 27 Nov 2001 07:35:43 -0500
Received: from mx0.gmx.de ([213.165.64.100]:48132 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S277541AbRK0Mfd>;
	Tue, 27 Nov 2001 07:35:33 -0500
Date: Tue, 27 Nov 2001 13:35:26 +0100 (MET)
From: ragnagock@gmx.de
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Re: Bootdisk minikernel to load full kernel via /linuxrc
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0004399983@gmx.net
X-Authenticated-IP: [149.225.91.172]
Message-ID: <7800.1006864526@www46.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 26, 2001 at 01:01:49PM +0100, ragnagock@gmx.de wrote:
> > 
> > Sorry, I forgot to mention that I want to have all partitions encrypted.
> 
> Would you please explain the utility in having the /boot
> partition encrypted?  It seems to me that if this one
> partition existed, and was plain-text, most, if not all,
> of your problems would go away.
> 

The goal is to have a machine where all hard disk content is encrypted so
an attacker has first to crack this to gain information. The problem is:
how to boot? I thought of a key disk with the decryption keys an a small
kernel to decrypt the parts needed to initiate an "normal" boot (i.e.
kernel, mount, the config files...). Then the decrypted kernel form hard
disk
is started and takes over the system. This way one kann recompile and patch
the kernel without having to watch the size available on the boot/key disk
and does not need to recreate it every time since it is thought to do a
capabilities implementation which would need a lot of recompiles to test...

To de-/encypt it is thought of using the existing method via loop/cryptoapi.

Btw: As there will be a kernel level capabilities implementation, an
attacker
should not be able to mess around with the kernel, so a plain-text boot
partition is out of question (the disk can be locked away).

As an explanation: I study on a polytechnical and my contribution
to this project will be my diploma.

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

