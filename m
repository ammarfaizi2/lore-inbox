Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269185AbRHBWjc>; Thu, 2 Aug 2001 18:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269193AbRHBWjX>; Thu, 2 Aug 2001 18:39:23 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26889 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269185AbRHBWjK>; Thu, 2 Aug 2001 18:39:10 -0400
Date: Fri, 3 Aug 2001 00:39:16 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.7+ext3 OOM (no swap) freeze?
Message-ID: <20010803003916.A8035@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was just building doxygen 1.2.9 RPMs on a SuSE 7.1 box which I
equipped with a 2.4.7 kernel that I patched ext 0.9.5 and NFS client
bugfixes into. When it was compiling a big .cpp file with g++, the
machine somewhat froze. Network layer was ok, I/O wasn't. No log-ins
possible, HDD spun down after some time.

(I can't tell whether SysRq would have worked, I forgot SuSE has set this
to 0 when I reinstalled the box after a HDD failure.)

I later figured that this particular g++ process burns a lot of memory
(like 50 MB), with the machine offering 96 MB RAM, and I forgot to
enable swap.

I'm not sure if the freeze is ext3 related (freeze when it's supposed to
commit some dirty buffers to disk and needs some pages for commit?) or
if plain 2.4.7 would freeze as well.

Regretfully, no syslog output (logs across network) gives any hints.

Hints for systematic debugging of yet-unknown bugs appreciated.

HTH,

-- 
Matthias Andree
