Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVBAM2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVBAM2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 07:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVBAM2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 07:28:18 -0500
Received: from [195.23.16.24] ([195.23.16.24]:16296 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262002AbVBAM2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 07:28:14 -0500
Message-ID: <41FF75C0.6040602@grupopie.com>
Date: Tue, 01 Feb 2005 12:27:44 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [PATCH 2.6] 7/7 replace snd_kmalloc_strdup by kstrdup
References: <1107228526.41fef76e4c9be@webmail.grupopie.com> <s5h651ch6lc.wl@alsa2.suse.de>
In-Reply-To: <s5h651ch6lc.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Tue,  1 Feb 2005 03:28:46 +0000,
> "" <pmarques@grupopie.com> wrote:
> 
>>[1  <text/plain; iso-8859-1 (quoted-printable)>]
>>
>>This patch removes the strdup implementation from the sound core
>>(snd_kmalloc_strdup), and updates it to use the kstrdup library function.
>>
>>Signed-off-by: Paulo Marques <pmarques@grupopie.com>
> 
> 
> This patch won't work properly if CONFIG_SND_DEBUG_MEMORY is set...

Humm.. compiles ok here.

I just rebuilt a vanilla 2.6.11-rc2-bk9 tree, applied the patches, 
selected CONFIG_SND_DEBUG and CONFIG_SND_DEBUG_MEMORY, and it compiled 
just fine.

I had already tested the patches with an allyesconfig, but tested it 
anyway just to be sure.

Are you sure you also applied the first patch in the series that creates 
the kstrdup library function? If you are, can you send me your .config 
so that I can test it here?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
