Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVL2UKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVL2UKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVL2UKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:10:43 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:17668 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750945AbVL2UKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:10:42 -0500
Date: Thu, 29 Dec 2005 21:13:50 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20051229211350.4115b799.khali@linux-fr.org>
In-Reply-To: <200512292100.27536.zippel@linux-m68k.org>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	<1135726855.6709.4.camel@localhost>
	<20051228210257.16c7a647.khali@linux-fr.org>
	<200512292100.27536.zippel@linux-m68k.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

> On Wednesday 28 December 2005 21:02, Jean Delvare wrote:
> 
> > +	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || 
> (VIDEO_SAA7134_ALSA=m && m))
> 
> Please do it a little less uglier, simply "!VIDEO_SAA7134_ALSA" is enough.

No, it wouldn't produce the desired effect anymore.

(!VIDEO_SAA7134_ALSA || (VIDEO_SAA7134_ALSA=m && m)) makes it possible
to compile both OSS and ALSA support as modules. Simplifying to
!VIDEO_SAA7134_ALSA would make it impossible.

Thanks,
-- 
Jean Delvare
