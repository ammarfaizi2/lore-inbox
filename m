Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTK0XJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTK0XJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:09:14 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:7040 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S261575AbTK0XJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:09:11 -0500
Date: Fri, 28 Nov 2003 01:07:26 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test11 setup.S assembler messages
Message-ID: <20031128000726.GA4215@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this problem appeared in earlier test-versions,
or if it's just a problem with my current system somehow, but
I thought it would be best to report this warning I get at the
very end of the compiling-process. I'm no programmer or kernel-
developer, so there is no way for me to tell of what significance
this is.

Anyway, I get this message even after a 'make mrproper', so I'm
quite sure it's not a problem with old junk-files or something.
When I look in setup.S at line 165, I find nothing but a reference
to MAXMEM-1 or something like that, and it does seem odd that the
value gets truncated into an identical value (unless the value was
truncated before the message got printed, that is).

---------------------------------------
  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff
  LD      arch/i386/boot/setup
---------------------------------------

I'm running i386-systems with the test11-kernel. I got the same
message on two different computers, one AMD Athlon TBird, and one
Intel Celeron.

Is this a known problem, and is there a fix to this somehow?

-- 
Tim Cambrant <tim@cambrant.com> 
GPG KeyID 0x59518702
Fingerprint: 14FE 03AE C2D1 072A 87D0  BC4D FA9E 02D8 5951 8702
