Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbVBCSn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbVBCSn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbVBCSlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:41:04 -0500
Received: from epithumia.math.uh.edu ([129.7.128.2]:49863 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id S263698AbVBCSjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:39:55 -0500
To: howarth@bromo.msbb.uc.edu (Jack Howarth)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: usb hotplug problems with 2.6.10
References: <20050203150310.65CB71DC09A@bromo.msbb.uc.edu>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: Thu, 03 Feb 2005 12:39:29 -0600
In-Reply-To: <20050203150310.65CB71DC09A@bromo.msbb.uc.edu> (Jack Howarth's
 message of "Thu,  3 Feb 2005 10:03:10 -0500 (EST)")
Message-ID: <ufaekfxh4im.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JH" == Jack Howarth <howarth@bromo.msbb.uc.edu> writes:

JH> Alan, I had mentioned a couple weeks back that with kernel 2.6.10,
JH> the ability to hotplug usb keys in Fedora Core 2 and 3 has been
JH> broken.

The true issue is a little more complicated than that.  The kernel
issue here is that under 2.6.9 (or Red Hat's versions thereof)
usb-storage devices would be picked up by the SCSI layer immediately
after the usb-storage module became aware of them.  Under Red Hat's
2.6.10 (which currently includes -ac11) there is a delay of
five or ten seconds between the device appearing in
/sys/bus/usb/drivers/usb-storage and it showing up as a SCSI device.

This delay has broken some stuff.  Yes, Red Hat's userland hotplugging
bits made incorrect assumptions and should be fixed.  The question is
whether this kernel delay is intended and, if not, how to fix it.
Even after I've hacked around the userland problems I still have
people asking why it takes so long for their USB keys to show up.

 - J<
