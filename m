Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVDEIWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVDEIWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVDEITQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:19:16 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:59106 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261649AbVDEISc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:18:32 -0400
Message-ID: <425249CD.7060506@ens-lyon.org>
Date: Tue, 05 Apr 2005 10:18:21 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?

I'm sorry, I did not follow this "PM resume broken" thread.

But, suspend to disk does not work here, at least since 2.6.12-rc1-mm4
(I can't be sure about other releases, I don't use suspend-to-disk
intensively).

Basically, "Freeing memory" looks much slower than before but suspend
finally looks ok.
When resuming, it says it's restarting tasks. But actually it does not
resume anyone of my real applications.

Here's a part of what I see with rc2-mm1:

input: AT Translated Set 2 keyboard on isa0060/serio0
Stopping tasks: =<6>Synaptics Touchpad, model: 1
Firmware: 5.8
180 degree mounted touchpad
[...]
   -> pass-through port
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
atkbd: probe of serio5 failed with error -19
input: PS/2 Generic Mouse on synaptics-pt/serio0
Restarting tasks...<6> Strange, kseriod not stopped
done

Actually, most of these lines appear when booting a fresh kernel.
The resume-specific ones are "Stopping tasks", "Restarting tasks"
and "Strange, kseriod not stopped".

Brice
