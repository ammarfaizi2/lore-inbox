Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTE3D7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 23:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTE3D7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 23:59:09 -0400
Received: from ajax.cs.uga.edu ([128.192.251.3]:2699 "EHLO ajax.cs.uga.edu")
	by vger.kernel.org with ESMTP id S263245AbTE3D7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 23:59:08 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: whither patch that fixed K6 32M bug on 2.1.56?
From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 30 May 2003 00:12:26 -0400
Message-ID: <8765ntyswl.fsf@cs.uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I just bought a computer (cheap!) that appears to have a K6
processor with the bug this website is dedicated to:

  http://membres.lycos.fr/poulot/k6bug.html

The problem appears to be a hardware glitch in the K6 where it gets
overly paranoid about self-modifying code.  There is a patch at the
above website that changes the 2.1.56 kernel thusly:

  Description : If page A is a code page, and A+32MB is a data page,
  then the bug can occur. If the memory allocation is modified to
  prevent these collisions, the failure rate should decrease
  dramatically.

Has anyone done anything with this patch since 2.1.56?  I see some
stuff in 2.4.20 that appears to test for the bug and print a warning
that the system may be unstable on detection.

-- 
--Ed L Cashin     PGP public key: http://noserose.net/e/pgp/

