Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289563AbSBEPB0>; Tue, 5 Feb 2002 10:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSBEPBQ>; Tue, 5 Feb 2002 10:01:16 -0500
Received: from ns.muni.cz ([147.251.4.33]:25342 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S289563AbSBEPA6>;
	Tue, 5 Feb 2002 10:00:58 -0500
Date: Tue, 5 Feb 2002 16:00:54 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix 2.4.18-pre8 compile error in cosa.c
Message-ID: <20020205150054.GE11523@informatics.muni.cz>
In-Reply-To: <Pine.NEB.4.44.0202051546330.24218-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0202051546330.24218-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
: the patch below fixes the following compile error in 2.4.18-pre8:

	Looks OK, please apply.

: --- drivers/net/wan/cosa.c.old	Tue Feb  5 15:37:20 2002
: +++ drivers/net/wan/cosa.c	Tue Feb  5 15:47:37 2002
: @@ -105,13 +105,6 @@
:  #include <net/syncppp.h>
:  #include "cosa.h"
: 
: -/* Linux version stuff */
: -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
: -typedef struct wait_queue *wait_queue_head_t;
: -#define DECLARE_WAITQUEUE(wait, current) \
: -	struct wait_queue wait = { current, NULL }
: -#endif
: -
:  /* Maximum length of the identification string. */
:  #define COSA_MAX_ID_STRING	128

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|\    As anyone can tell you trying to force things on Linux developers   /|
|\\   generally works out pretty badly.              (Alan Cox in lkml)  //|
