Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313675AbSDHPfA>; Mon, 8 Apr 2002 11:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313676AbSDHPfA>; Mon, 8 Apr 2002 11:35:00 -0400
Received: from [62.245.135.174] ([62.245.135.174]:22950 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313675AbSDHPe7>;
	Mon, 8 Apr 2002 11:34:59 -0400
Message-ID: <3CB1B89D.13DDF456@TeraPort.de>
Date: Mon, 08 Apr 2002 17:34:53 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre3-ac3-mkn i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: pavel@ucw.cz
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp fixes] Re: Linux 2.4.19pre5-ac3
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/08/2002 05:34:52 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/08/2002 05:34:59 PM,
	Serialize complete at 04/08/2002 05:34:59 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [swsusp fixes] Re: Linux 2.4.19pre5-ac3
> 
> +
> +You have two ways to use this code. The first one is if you've compiled in
> +sysrq support then you may press Sysrq-D to request suspend. The other way
> +is with a patched SysVinit (my patch is against 2.76 and available at my
> +home page). You might call 'swsusp' or 'shutdown -z <time>'.
> +
> +Either way it saves the state of the machine into active swaps and then
> +reboots. By the next booting the kernel's resuming function is either triggered
> +by swapon -a (which is ought to be in the very early stage of booting) or you
> +may explicitly specify the swap partition/file to resume from with ``resume=''
> +kernel option. If signature is found it loads and restores saved state. If the

 Does it have to be an "active swap partition"? What about systems
without active swap, but space enough for a partition?

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
