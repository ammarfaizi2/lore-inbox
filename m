Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbTGJMJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbTGJMJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:09:09 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:55218 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S269237AbTGJMJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:09:00 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Odd goings on for new 2.4.22-preX builds
Date: Thu, 10 Jul 2003 08:23:38 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307100823.38982.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.62.27] at Thu, 10 Jul 2003 07:23:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets list;

I, like many, use a couple of scripts to build new kernels.  I'd 
characterize myself as knowing just enough C to be dangerous, only 
having used it since the early 80's, but the years on the grey matter 
also effect that, 68 of those.

One of the 'features' of my buildit script is to mv the old base tree 
out of the way when I'm unpacking another copy of it to be used as 
the new tree.  That way I can revert by mv'ing it back if the new one 
fubars somehow.

However, after using it to make a 2.4.22-pre3, then my 'makeit' script 
has a 100% failure while making modules.  Something is refering back 
to the running kernels /lib/modules/version/kernel/build directory, 
where 'build' is a link back to the source tree of the running 
kernel.  Which is of course an invalid link if that tree has been 
renamed.

This doesn't seem too kosher to me as the running kernel probably 
should have exactly zip to do with the one under construction.

I've managed to fix it by mv'ing the original kernels src tree back to 
its original name once the unpacked new tree has been mv'd to the 
patchname in my buildit script.  So I'm running 2.4.22-pre3 now.

The question is: why should I have to do that?  Why should the kernel 
under construction, in this case 2.4.22-pre3, care about or need  
whats in the 2.4.21/.config file?  That was the reference that leads 
to the compilers eventual demise.

If it matters, system is the Athlon below, RH8.0, most updates 
applied.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

