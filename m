Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVBKWfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVBKWfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVBKWfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:35:14 -0500
Received: from mail.linicks.net ([217.204.244.146]:56460 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262373AbVBKWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:35:06 -0500
From: Nick Warne <nick@linicks.net>
To: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
Date: Fri, 11 Feb 2005 22:34:59 +0000
User-Agent: KMail/1.7.2
References: <200502111804.06899.nick@linicks.net> <20050211184821.GC15721@redhat.com> <20050211221956.GO24747@hygelac>
In-Reply-To: <20050211221956.GO24747@hygelac>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502112234.59690.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 February 2005 22:19, Terence Ripperda wrote:

> >  > I just read through the nVidia readme file, and there is a
> >  > comprehensive section on what module to use for what chipset (and
> >  > card).  It recommends using the nVagp for my setup,
>
> is that the "CONFIGURING AGP" appendix? I didn't think that we
> recommended which agp driver to use. the intention was just to
> document which chipsets are supported by nvagp and point out that
> agpgart may/probably supports more chipsets. that section also
> documents some hardware 'issues' that we work around. we work around
> these issues regardless of which agp driver is being used.

Thats the one.  I read this in APPENDIX F:

"The following AGP chipsets are supported by NVIDIA's AGP; for all other
chipsets it is recommended that you use the AGPGART module."

as saying 'if you have one of these chipsets use nVagp' else use agpgart.

> for this via kt133 issue, I looked through the agpgart and nvagp
> initializations and didn't see anything much different. both
> initialize and flush gart mappings the same way. both seem to allocate
> memory the same way (nvagp uses __get_free_pages, which eventually
> calls alloc_pages) with the GFP_KERNEL flag.  I'm not sure why there
> would be much difference between the two.

I have had no issue at all running agpgart on Slackware 10 with KDE 3.3.x.  It 
was just when I read this thread I didn't realise there was another option of 
a different NV module.  I just tried it after reading deeper in the 
readme.txt ref. the Quake2 OpenGL 'rippling wave' I get every 5 minutes or 
so.  It fixed it, BTW.  I now have a constant clear display 100% in Quake2 :)  
I haven't noticed any difference at all in 2d desktop stuff (except maybe it 
is slightly brighter).

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
