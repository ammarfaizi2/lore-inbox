Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265707AbSJTAVw>; Sat, 19 Oct 2002 20:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbSJTAVw>; Sat, 19 Oct 2002 20:21:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15620 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265707AbSJTAVv>; Sat, 19 Oct 2002 20:21:51 -0400
Date: Sun, 20 Oct 2002 01:27:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: More Makefile Misery
Message-ID: <20021020012750.C21819@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running make clean on an ARM tree, I get:

make[1]: *** No rule to make target `arch/arm/mach-/Makefile'.  Stop.

Seeing as we have many mach-* directories, and the relevant one is
selected by the relevant .config file.

I see two options:

- recurse into the correct one somehow, given that the .config file may
  have changed since the kernel tree was built.
- recurse into all mach-* directories for make clean and not for the
  normal build

(Its late, I've not looked at the makefiles yet)

Comments?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

