Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbRCMDDp>; Mon, 12 Mar 2001 22:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbRCMDDf>; Mon, 12 Mar 2001 22:03:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55680 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130793AbRCMDDQ>;
	Mon, 12 Mar 2001 22:03:16 -0500
Message-ID: <3AAD8DB4.9DAC348C@mandrakesoft.com>
Date: Mon, 12 Mar 2001 22:02:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Modular versus non-modular ISAPNP (was Re: PATCH - compile fix for 
 3c509.c in 2.4.3-pre3)
In-Reply-To: <15021.30069.381855.886337@notabene.cse.unsw.edu.au>
		<Pine.LNX.3.96.1010312194658.4742A-100000@mandrakesoft.mandrakesoft.com> <15021.36013.606715.731130@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Monday March 12, jgarzik@mandrakesoft.com wrote:
> > On Tue, 13 Mar 2001, Neil Brown wrote:
> > >  in 2.4.3-pre3, drivers/net/3c509.c will not compile ifdef CONFIG_ISAPNP.
> > >
> > >  The following patches fixes the error.  I suspect that 3c515.c has
> > >  the same problem, but I didn't need to fix that to get my kernel to
> > >  build... so I didn't.

> > 3c509 and 3c515 fixes already sent to him, twice no less :)

> Drat... I didn't remember seeing it go by on linux-kernel, but maybe I
> didn't pay enough attention.... next time I'll wait till the same
> problem appears in two pre releases before patching...

(re cc'd to lkml...)

My fault on that one, I didn't send it to lkml...

BTW if you noticed, this problem was undetected initially due to
differences between CONFIG_ISAPNP and CONFIG_ISAPNP_MODULE in the
source.

It is highly recommended to always compile with CONFIG_ISAPNP=y due to
these differences.  If you grep around for CONFIG_ISAPNP versus
CONFIG_ISAPNP_MODULE, you'll see that many drivers are woefully
unprepared for isapnp support compiled as a module.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
