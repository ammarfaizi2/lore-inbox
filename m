Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUKAPCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUKAPCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUKAOn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:43:59 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:49579 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S265339AbUKAOdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:33:52 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Date: Mon, 1 Nov 2004 08:32:38 -0600
Message-ID: <OF7D48BC89.318047B1-ON86256F3F.004FE424-86256F3F.004FE4A1@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/01/2004 08:32:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've uploaded -V0.6.5 to the usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/

Hmm. I was in the middle of a V0.6.4 build when I saw this message.
I let it run but the build stopped with the following error:

  CC [M]  drivers/scsi/qla2xxx/qla_os.o
  CC [M]  drivers/usb/media/stv680.o
drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_do_dpc':
drivers/scsi/qla2xxx/qla_os.c:3193: warning: implicit declaration of
function `DECLARE_MUTEX_LOCKED'
drivers/scsi/qla2xxx/qla_os.c:3193: error: `sem' undeclared (first use in
this function)
drivers/scsi/qla2xxx/qla_os.c:3193: error: (Each undeclared identifier is
reported only once
drivers/scsi/qla2xxx/qla_os.c:3193: error: for each function it appears
in.)
drivers/scsi/qla2xxx/qla_os.c:3194: warning: ISO C90 forbids mixed
declarations and code

Based on my quick review of the updated patch, I don't see a fix for this
so I'll remove it from .config (and step up to V0.6.5) but if you get a
chance to fix this, please do.
  --Mark

