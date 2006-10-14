Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752165AbWJNLZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWJNLZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbWJNLZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:25:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35857 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752165AbWJNLZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:25:37 -0400
Date: Sat, 14 Oct 2006 13:25:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Prakash Punnoor <prakash@punnoor.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>, v4l-dvb-maintainer@linuxtv.org
Subject: [2/3] 2.6.19-rc2: knwon regressions with workarounds
Message-ID: <20061014112534.GK30596@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014111458.GI30596@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions with workarounds in 2.6.19-rc2 
compared to 2.6.18.

Unless proper solutions become available, we should implement the 
workarounds.

If you find your name in the Cc header, you are either submitter of one 
of the bugs, maintainer of an affectected subsystem or driver, a patch 
of you caused a breakage or I'm considering you in any other way 
possibly involved with one or more of these issues.

Please trim the Cc when answering.

Subject    : snd-hda-intel <-> forcedeth MSI problem
References : http://lkml.org/lkml/2006/10/5/40
             http://lkml.org/lkml/2006/10/7/164
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : suggested workaround for 2.6.19:
             deactivate MSI in snd-intel-hda by default


Subject    : DVB frontend selection causes compile errors
References : http://lkml.org/lkml/2006/10/8/244
Submitter  : Adrian Bunk <bunk@stusta.de>
Caused-By  : "Andrew de Quincey" <adq_dvb@lidskialf.net>
             commit 176ac9da4f09820a43fd48f0e74b1486fc3603ba
Handled-By : Michael Krufky <mkrufky@linuxtv.org>
             "Andrew de Quincey" <adq_dvb@lidskialf.net>
Status     : possible workaround: don't allow CONFIG_DVB_FE_CUSTOMISE=y

