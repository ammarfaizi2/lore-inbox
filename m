Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWBUTfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWBUTfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 14:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWBUTfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 14:35:22 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:29351 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1030179AbWBUTfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 14:35:21 -0500
Message-ID: <43FB6B8A.6070904@keyaccess.nl>
Date: Tue, 21 Feb 2006 20:35:38 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp cards)
 broken in 2.6.16-rc4
References: <43F9F9F2.4070203@keyaccess.nl>	<s5hu0askd7e.wl%tiwai@suse.de>	<43FB3718.6060503@keyaccess.nl> <s5hek1wk3op.wl%tiwai@suse.de>
In-Reply-To: <s5hek1wk3op.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

> Rene Herman wrote:

>> "ALSA sound/core/device.c:106: device free eee4e000 (from f099153d), not 
>> found"

> This is harmless.  The opl3-oss instance was already freed but the
> driver tries to release it again just to be sure.
> 
> The patch below should fix this annoyance.

Ah, good. Yes, it ofcourse does. Thanks. So, only the isapnp/bustype one 
was in fact a problem, it seems...

Rene.
