Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVGOCfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVGOCfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVGOCfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:35:22 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:1342 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261815AbVGOCfU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EFdIH/1cSQfIH58Kc9/75PkFAH1P6dB3xI+yZSQdXr/PpwF9fbI/jKjN1qKzzlMoNAAQ0LBhDiM2sfo5BPG37oQ8jkb4ALrglFEBwMiw5FOLt/OEaVGb0LMLvN9DQmE8ThI4G8lxi9n3T8RBSyvajJ52zZUoNX3J7oWnGSaMyco=
Message-ID: <105c793f0507141935403fc828@mail.gmail.com>
Date: Thu, 14 Jul 2005 22:35:19 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: suspend2-users <suspend2-users@lists.suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PS/2 Keyboard is dead after resume.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm using Linux Kernel 2.6.12.2 plus suspend 2.1.9.9 and acpi-20050408
with the hibernate-1.10 script. My machine is a Shuttle SK43G which
has a VIA KM400 chipset with an Athlon XP CPU.

Suspension seems to work well. However, when I resume, the keyboard is
dead and there is a warning in dmesg before and after suspension:

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
Please include the following information in bug reports:
- SUSPEND core   : 2.1.9.9
- Kernel Version : 2.6.12.2
- Compiler vers. : 3.3
- Attempt number : 1
- Pageset sizes  : 5821 (5821 low) and 118350 (118350 low).
- Parameters     : 0 32 0 1 0 5
- Calculations   : Image size: 124376. Ram to suspend: 2240.
- Limits         : 126960 pages RAM. Initial boot: 123894.
- Overall expected compression percentage: 0.
- Compressor lzf enabled.
  Compressed 508604416 bytes into 23739845 (95 percent compression).
- Swapwriter active.
  Swap available for image: 487964 pages.
- Filewriter inactive.
- Preemptive kernel.
- Max extents used: 4
- I/O speed: Write 251 MB/s, Read 198 MB/s.
Resume block device is defe0860.
Real Time Clock Driver v1.12
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.


This machine doesn't have XFree86 on it.

I am presuming that this is a bug since I've used the exact same
kernel+patches (with hibernate 1.09 script) on another machine without
issues. I'm not sure if it's a suspension bug or if it's a kernel bug
that is brought to light by the suspend2 patches. If I'm wrong and
I've made a mistake, I'd love to hear it.

Thanks.

-Andy
