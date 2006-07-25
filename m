Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWGYUBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWGYUBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWGYUBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:01:50 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:34694 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964848AbWGYUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:01:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K8jiep/R9RMu3X4bM46FyXm4+c9PsVjSIXFBbpne0Z4/VOW47QVAjUa9rXFdvplrBCZoavP/B78/53ZzHhZEVDT7fHJObV5hT9uE5SpEcHkwicG0OLgF+FrLfIwfrSq+wARsF6Z7gDU9mWAosdrXD/13x/7zYb3AgOOeLlRvcV8=
Message-ID: <2151339d0607251301i716f6a01i17b07de5e7905ffc@mail.gmail.com>
Date: Tue, 25 Jul 2006 13:01:49 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel panic when sending MIDI sequencer events
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting a kernel panic when a program sends a MIDI sequencer
event.  Seems to happen in all recent kernels I've tested.  Currently
I'm using 2.6.17.7 on an AMD X2 4800+ Nforce4 (Gigabyte K8NXP-SLI)
system running Slamd64 10.1 in 64-bit mode. I'm using the ALSA sound
modules for intel8x0 for the motherboard sound chip.  I should mention
that PCM sound works fine, no crashes and sounds OK.  If I understand
correctly, the intel8x0 does not directly support MIDI sound.  I guess
this means I need to install Timidity or something to make MIDI sound
actually work, but this is of secondary concern.  My primary concern
is that when programs send a MIDI event, it crashes the whole system.

Here is an excerpt from the error message as I've copied it from the console:

Call Trace: <ffffffff8038da4d>{rtc_control+56}
<ffffffff880b3063>{:snd_rtctimer:rtctimer_start+28}

...more stuff like that.  Also mentions snd_seq:snd_seq_control_queue+153
snd_seq:snd_seq_deliver_single_event+281
snd_seq:snd_seq_deliver_event+337
snd_seq:queueptr+60
snd_seq_client_enqueue_event+119

Any help would be greatly appreciated.  Please cc me directly.

thanks,

Nathan
