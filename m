Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVCYXO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVCYXO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCYXO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:14:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42989 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261870AbVCYXO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:14:26 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Lee Revell <rlrevell@joe-job.com>
To: Julien Wajsberg <julien.wajsberg@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2a0fbc59050325145935a05521@mail.gmail.com>
References: <2a0fbc59050325145935a05521@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 18:14:22 -0500
Message-Id: <1111792462.23430.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> - audio works too. The only problem is that two applications can't
> open /dev/dsp in the same time.

Not a problem.  ALSA does software mixing for chipsets that can't do it
in hardware.  Google for dmix.

However this doesn't (and can't be made to) work with the in-kernel OSS
emulation (it works fine with the alsa-lib/libaoss emulation).  So you
are technically correct in that two OSS apps can't open /dev/dsp at the
same time, but there is no problem with multiple apps sharing the sound
device, as long as they use the ALSA API (which they should be using
anyway).

Lee




