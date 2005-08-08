Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVHHNUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVHHNUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVHHNUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:20:09 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:64633 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750862AbVHHNUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:20:08 -0400
Message-ID: <42F75C0D.3030409@linuxtv.org>
Date: Mon, 08 Aug 2005 09:20:13 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org,
       Mac Michaels <wmichaels1@earthlink.net>
Subject: Re: [PATCH] DVB: lgdt330x frontend: some bug fixes & add lgdt3303
 support
References: <42F6A294.90300@linuxtv.org> <1123504387.17427.9.camel@localhost>
In-Reply-To: <1123504387.17427.9.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:

>	This should't be applied to 2.6.13. It does contain a hack at V4L code,
>since mute_tda9887 is implemented outside tda9887.c module and could
>potentially cause troubles since there are some work to provide it on a
>correct way.
>	 It should be applied to -mm and go to mainstream only after provided a
>correct implementation.
>
>Mkrufky,
>	Please avoid trying to submit yet experimental patches to mainstream.
>
>Mauro.
>
Mauro-

Please calm down... This is a newer version of the frontend module.  It 
is DVB code, not v4l.  The new frontend module contains the MUTE_TDA9887 
hack, however, the code is disabled.  The new DVB frontend module has 
some bugfixes.  This is NOT experimental code.  It has been testing in 
cvs for the past month and Mac and I have verified that this code works, 
and is a significant improvement over current lgdt330x code in -linus 
tree.  I did NOT send the v4l stuff to Andrew.  FusionHDTV5 Gold DVB 
mode is still disabled in cx88-cards.c.  THIS UPDATE IS A BUGFIX.

Mac and I have been testing this new frontend module for the past few 
weeks.  After Mac's latest changes to the lgdt330x module, it is now 
ready to go upstream.  This module provides better quality digital tv 
reception, and adds support for LGDT3303.  There is no reason this 
cannot go to 2.6.13.  It is Andrew's choice of whether he wishes to fwd 
to Linus or not.

The tda9887 stuff is disabled inside the code with #ifdefs.

Mauro, please do not intercept my patches to Andrew about DVB stuff.  I 
have not kept you informed about Mac's DVB stuff because you are v4l 
maintainer. (not dvb maintainer).  Mac and I have worked very hard on 
this.  Most of our correspondence have been short little emails and we 
have been communicating in pvt emails, rather than using the list. These 
patches for the new lgdt330x have been tested by many DViCO users, using 
the cvs-tree-merging scripts.   I have discussed these code changes with 
Johannes, and he is happy for me to handle the hybrid patches like 
this.  It is very important that the changes made to the lgdt330x module 
be countered by equivalent changes in cx88-dvb.c

Once again, this is NOT an "experimental patch," and THIS is the correct 
implementation for lgdt330x stuff.....  The tda9887 stuff can be removed 
later on.  It is harmless right now, as the tda9887 code is disabled by 
ifdefs anyway.  It would be best for the new lgdt330x module to be 
merged into 2.6.13, because the interface is no longer compatable with 
older lgdt330x interface.

Thank you.

-- 
Michael Krufky

