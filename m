Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSDETNX>; Fri, 5 Apr 2002 14:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313496AbSDETNN>; Fri, 5 Apr 2002 14:13:13 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:21482 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313492AbSDETNK>; Fri, 5 Apr 2002 14:13:10 -0500
Date: Fri, 05 Apr 2002 11:13:01 -0800
From: "Martin J. Bligh" <fletch@aracnet.com>
To: linux-kernel@vger.kernel.org
Subject: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <1650399759.1018005181@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My real motivation for this isn't actually faster reboots,
it's rebooting at all - I have some strange hardware that
won't do init 6 in traditional ways ... but it might mean
a faster reboot for others.

What's to stop me rebooting by having machine_restart load
the first sector of the first disk (as the BIOS does), where
the LILO code should be, and just jumping to it?

1. Are there tables that are created by the BIOS that we 
destroy during Linux runtime? mps tables spring to mind - 
I can't see where we preserve them ...

2. Things that are reset by reboot that we don't reset during
normal kernel boot?

As a side effect, this means we could potentially take 
crashdumps on the way up, rather than the way down, so
the kernel is more likely to be in a working state (we'd
have to load a minimal kernel / crashdumper to take the
dump first ... this is similar to what we did with PTX).

M.

