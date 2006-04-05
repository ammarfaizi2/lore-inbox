Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWDEXcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWDEXcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWDEXcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:32:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:34004 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751054AbWDEXcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:32:35 -0400
X-Authenticated: #31060655
Message-ID: <44345391.4000704@gmx.net>
Date: Thu, 06 Apr 2006 01:32:33 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix unneeded rebuilds in drivers/media/video after moving
 source tree
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org> <442C4469.1040408@gmx.net> <20060331152226.GB8992@mars.ravnborg.org> <4431A338.3000709@gmx.net> <20060404150233.GA10608@mars.ravnborg.org>
In-Reply-To: <20060404150233.GA10608@mars.ravnborg.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg schrieb:
>>This fixes some uneeded rebuilds under drivers/media/video after moving
>>the source tree. The makefiles used $(src) and $(srctree) for include
>>paths, which is unnecessary. Changed to use relative paths.
>>
>>Compile tested, produces byte-identical code to the previous makefiles.
> 
> 
> Thanks, applied both.
> Did similar changes in bt8xx + some ppc code.

Thanks. Was it intentional to leave the line below in
drivers/media/video/bt8xx/Makefile?

EXTRA_CFLAGS += -I$(src)/..

I think it could be replaced with

EXTRA_CFLAGS += -Idrivers/media/video

but I'm not a kbuild expert.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
