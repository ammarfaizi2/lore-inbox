Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbTBMER1>; Wed, 12 Feb 2003 23:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267787AbTBMER0>; Wed, 12 Feb 2003 23:17:26 -0500
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:54420 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP
	id <S267782AbTBMER0>; Wed, 12 Feb 2003 23:17:26 -0500
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: wingel@nano-systems.com, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
In-Reply-To: <1045106216.1089.16.camel@vmhack> (Rusty Lynch's message of "12
 Feb 2003 19:16:55 -0800")
References: <1045106216.1089.16.camel@vmhack>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Thu, 13 Feb 2003 15:27:14 +1100
Message-ID: <87n0l0olel.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (brussels sprouts)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2003, Rusty Lynch wrote:
> The following is a proposal for a new sysfs based watchdog interface
> to be used as a replacement for the current char device w/ ioctl api
> as described in Documentation/watchdog-api.txt.

[...]

> Where each these files to the following ==>
> 
> start (RO)
>   - show: starts watchdog count

This would be much better as a store -- that way 'cat /.../watchdog0/*'
will not activate the watchdog. A more deliberate action is safer for
forgetful admins, such as me.

[...]

> status (RO)
>   - show: prints the current status value
> 
> bootstatus (RO)
>   - show: same as 'status', but valid for just after the last reboot.

[...]

> enable (RW)
>   - show: prints 0 or 1 to indicate if the wdt is enabled
>   - store: expects 0 or 1 to disable or enable the wdt

Isn't this the same information as the 'status' and 'start' members?

      Daniel

-- 
A cathedral, a wave of a storm, a dancer's leap,
never turn out to be as high as we had hoped.
        -- Marcel Proust
