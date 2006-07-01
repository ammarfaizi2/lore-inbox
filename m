Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWGAMWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWGAMWo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 08:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGAMWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 08:22:44 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:58795 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751119AbWGAMWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 08:22:43 -0400
Message-ID: <44A66911.50309@dgreaves.com>
Date: Sat, 01 Jul 2006 13:22:41 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix SCO on some bluetooth adapters (Success report for
 Belkin F8T012)
References: <20060420140517.GA72089@dspnet.fr.eu.org>
In-Reply-To: <20060420140517.GA72089@dspnet.fr.eu.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> Some bluetooth adapters return an incorrect number of sco packets in
> READ_BUFFER_SIZE.  Add a quirk hook to fix it from the driver side,
> and use the hook for a first adapter.
> 
> Signed-off-by: Olivier Galibert <galibert@pobox.com>
> 
> ---
> 
> I tried to take Marcel Holtmann's remarks into account, but he seems
> unavailable to tell me whether he likes that version, so I'll send it
> to the whole shebang instead of just him this time.
> 
> The main point was "only the driver knows how to fix the problem",
> hence a function pointer quirk hook.  This is definitively not limited
> to broadcom USB devices, googling for "SCO MTU 64:0" has interesting
> results.
> 
> Pavel, '4' doesn't seem to be a value that happens in any correctly
> answering adapter, while 8 happens often.  Try "SCO MTU 64:4" and "SCO
> MTU 64:8" for comparison.
> 
> 
>  drivers/bluetooth/hci_usb.c      |   12 ++++++++++++
>  drivers/bluetooth/hci_usb.h      |    1 +
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |   16 ++++++++++++++--
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> 841d7690e75189803907fbc4616b984087e7f89c

Replying to an old email about a patch that hasn't made it yet (at least
to 2.6.17.3).

Without this patch I can't use my Belkin F8T012 with the bluetooth alsa
sound driver (snd-bt-sco)

with it, I can :)

Thanks Olivier.

Is this likely to be merged?


David

PS, I tried the patch here:
 http://bluetooth-alsa.sourceforge.net/sco-mtu.patch
that is mentioned here:
 http://bluetooth-alsa.sourceforge.net/
but it doesn't work for me.

-- 
