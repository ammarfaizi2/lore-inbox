Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVAEQTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVAEQTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVAEQSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:18:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3770 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262507AbVAEQCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:02:54 -0500
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark_H_Johnson@raytheon.com
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
In-Reply-To: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
References: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104936968.24187.180.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 14:56:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 14:21, Mark_H_Johnson@raytheon.com wrote:
> > The default blocking behavior of OSS devices was changed recently.
> > When the device is in use, open returns -EBUSY immediately in the
> > latest version while it was blocked until released in the former
> > version.
> I suppose there was a "good reason" for changing the user level
> interface in this way. Could you [or someone else] explain that and
> if you would consider changing it back (to stop breaking old applications)?
> Otherwise - is there some way (other than running lsmod and grep) to find
> out if the interface is busy and which application is using it?

OSS itself changed behaviour over time (2.2 to 2.4) ALSA has merely
caught up with the newer OSS behaviour and the new behaviour is correct.

If you want to find out if the interface is busy open it. If you want to
do it portably open it with O_NDELAY.

