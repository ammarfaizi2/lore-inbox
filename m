Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWGBVKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWGBVKV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGBVKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 17:10:21 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:58766 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750701AbWGBVKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 17:10:21 -0400
Date: Sun, 2 Jul 2006 23:08:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>,
       perex@suse.cz, Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
In-Reply-To: <1151854092.12026.39.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0607022304230.5218@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>  <44A54D8E.3000002@superbug.co.uk>
 <20060630163114.GA12874@dspnet.fr.eu.org>  <1151702966.32444.57.camel@mindpipe>
  <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>
  <44A76DDF.4020307@superbug.co.uk>  <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
 <1151854092.12026.39.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well you could patch the affected plugin's .dynstr table so that it should at
>> best try to call a function that has not yet been defined somewhere else (like
>> open); IOW, you change the .dynstr entry from 'open' to say 'my_open', and
>> regularly include libmy.so through e.g. LD_PRELOAD.
>> 
>> Of course the MD5 won't match afterwards, but I think the plugin should execute
>> as usual afterwards, since .dynstr is something no app should rely on.
>
>Is this likely to work with an app like Skype that takes extensive steps
>to thwart reverse engineers?

We do not reverse engineer the .text section, but change the .dynstr 
section that is specific to the ELF format. I doubt any app out there md5s 
itself.

>(Of course a Skype beta with ALSA support was just released, so it's
>much less important now)

A nice challenge anyhow!


Jan Engelhardt
-- 
