Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbULBUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbULBUHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbULBUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:07:22 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1737 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261322AbULBUHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:07:19 -0500
Subject: Re: [Jackit-devel] Re: Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.31-19
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Andrew Burgess <aab@cichlid.com>,
       linux-kernel@vger.kernel.org, jackit-devel@lists.sourceforge.net
In-Reply-To: <87hdn4eihw.fsf@sulphur.joq.us>
References: <200412021546.iB2FkK5a005502@cichlid.com>
	 <20041202170315.067d7853@mango.fruits.de> <87y8ggekds.fsf@sulphur.joq.us>
	 <20041202175756.0e50f101@mango.fruits.de>  <87hdn4eihw.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 15:07:15 -0500
Message-Id: <1102018036.31206.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 11:07 -0600, Jack O'Quin wrote:
> Is printk() guaranteed not to wait inside the kernel?  I am not
> familiar with its internal implementation.

Yes.  It just writes to a ring buffer and klogd dumps this to syslog.
So if you really start to spew printk's they don't all make it to the
log but you never get blocked.

The implementation probably looks a lot like a correct solution to fix
the printf-from-RT-context issue in JACK would.

Lee

