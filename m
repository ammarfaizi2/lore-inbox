Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUJBAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUJBAMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUJBAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:12:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33948 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266870AbUJBAML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:12:11 -0400
Subject: alsa-driver will not compile with kernel 2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1096675930.27818.74.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 20:12:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At first I thought my build was incorrect, but I reproduced this error
with a clean build and ALSA CVS from today:

  CC [M]  /home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o
/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3202:57: macro "io_remap_page_range" requires 5 arguments, but only 4 given
/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c: In function `snd_pcm_lib_mmap_iomem':
/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: `io_remap_page_range' undeclared (first use in this function)
/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: (Each undeclared identifier is reported only once
/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: for each function it appears in.)
make[3]: *** [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o] Error 1
make[2]: *** [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore] Error 2
make[1]: *** [_module_/home/rlrevell/cvs/alsa/alsa-driver/kbuild] Error 2
make[1]: Leaving directory `/home/rlrevell/kernel-source/linux-2.6.9-rc2-mm4-S7'
make: *** [compile] Error 2

I am not sure if this is an ALSA issue or -mm4.  I suspect -mm4 because
-mm3-S6 worked.  The VP patch does not seem to be involved.

Lee

