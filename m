Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRE3KbG>; Wed, 30 May 2001 06:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbRE3Ka4>; Wed, 30 May 2001 06:30:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45952 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262715AbRE3Kax>;
	Wed, 30 May 2001 06:30:53 -0400
Message-ID: <3B14CBD1.C4B5F169@mandrakesoft.com>
Date: Wed, 30 May 2001 06:30:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net #9
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <9f2enn$jbr$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" wrote:
> 
> Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> writes:
> 
> >-static char   name[4][IFNAMSIZ] = { "", "", "", "" };
> 
> >+static char   name[4][IFNAMSIZ];
> 
> Ugh. Sure about that one? the variables have been pointers to zero,
> now they're zero...

No, the variables were and always have been arrays, not pointers.

The previous incarnation, {"","","",""}, was actually doubly lame,
because not only was it an unnecessary zeroing of the var, but using ""
causes an extra string to be generated in the output asm.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
