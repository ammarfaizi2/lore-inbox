Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSFQMg3>; Mon, 17 Jun 2002 08:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSFQMg2>; Mon, 17 Jun 2002 08:36:28 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:26808 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S312590AbSFQMg0>; Mon, 17 Jun 2002 08:36:26 -0400
To: linux-kernel@vger.kernel.org
Subject: binary compatibity (mixing different gcc versions) in modules
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 17 Jun 2002 14:36:25 +0200
Message-ID: <7w3cvmdquu.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looking at nvidia proprietary driver, the makefile warns
the user against insmod'ing a module compiled with a gcc
version different from the one that was used to compile
the kernel.

This sounds strange to me, since I never encountered this
problem.

As a counterpart, what I'm sure of, is that you easily get system
crashes when insmod'ing a module resulting of the linking together 
(with ld -r) of object files (.o) that were not produced by the same gcc.

Can someone give me a clue on what happens?

Everything is compiled with:
cc 
 -O2 
 -DDEBUG=1
 -D__KERNEL__
 -DMODULE 
 -fomit-frame-pointer 
 -fno-strict-aliasing 
 -fno-common 
 -pipe 
 -mpreferred-stack-boundary=2  
 -Wno-import 
 -Wimplicit 
 -Wmain 
 -Wreturn-type 
 -Wswitch 
 -Wtrigraphs 
 -Wchar-subscripts 
 -Wuninitialized 
 -Wparentheses 
 -Wpointer-arith 
 -Wcast-align 
 -fcheck-new

One gcc is 
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
the other one is 2.95-2.

Would -O1 be a safer choice?

Sincerely yours,

PS. Let's avoid to fall in a open source vs. binary only dialectics
here, it's not really the point ;-)

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
