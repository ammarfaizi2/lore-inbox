Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUIPWHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUIPWHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIPWHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:07:30 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:64234 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267974AbUIPWGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:06:46 -0400
Subject: Re: [PATCH]: Suspend2 Merge: Device driver fixes 2/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <s5h8yba2n4s.wl@alsa2.suse.de>
References: <1095331535.3324.135.camel@laptop.cunninghams>
	 <s5h8yba2n4s.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1095372496.5897.15.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 08:08:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-09-17 at 02:29, Takashi Iwai wrote:
> No, snd_pcm_suspend_all() must be called.  All PCM streams are
> supposed to be moved to SUSPENDED state when the suspend happens.
> Keeping other states doesn't guaratee the proper resume process.
> 
> The problem of ali5451 driver was that it forgot to call
> snd_power_change_state() at the end of suspend callback.
> This was already fixed.

Is it merged to Andy or Linus yet? If so, I could drop the patch.

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

