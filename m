Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbREZWtE>; Sat, 26 May 2001 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbREZWsy>; Sat, 26 May 2001 18:48:54 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48077 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261334AbREZWsf>;
	Sat, 26 May 2001 18:48:35 -0400
Message-ID: <3B1032BE.72BD1336@mandrakesoft.com>
Date: Sat, 26 May 2001 18:48:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ingo T. Storm" <it@lapavoni.de>, rth@twiddle.net
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 2.4.5 does not link on Ruffian (alpha)
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <3B102822.625E01DF@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should note, though, that -not- using CONFIG_ALPHA_GENERIC seems to
have a detrimental effect on my machines, in 2.4.5 vanilla.

When built with CONFIG_ALPHA_NAUTILUS, my UP1000's IDE totally fails. 
It probes the drives ok, on boot, but a logic hang occurs where no more
boot progress can be made.  All I get are "hda: lost interrupt"
messages.  I am booting w/ aboot 0.7a from SRM, -without- the
srm-as-bootloader kernel config option.  These problems go away when
using the generic MDK alpha kernel, which is based on Alan's '2.4.4-ac'
patchkit, and uses CONFIG_ALPHA_GENERIC.

A very similar problem occurs on my new test alpha, a miata.  With
CONFIG_ALPHA_MIATA, IDE fails with "hda: lost interrupt" as above, but
additionally, the keyboard is no longer recognized.  Again, with MDK(ac)
kernel, things work fine.

After wondering for a while what magic was in the 'ac' patchkit, I
realized that my build needed CONFIG_ALPHA_GENERIC to work.  Tested that
theory... sure enough, I can boot 2.4.5-vanilla no problems now.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
