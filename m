Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbRGRN3N>; Wed, 18 Jul 2001 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbRGRN3D>; Wed, 18 Jul 2001 09:29:03 -0400
Received: from mail-klh.telecentrum.de ([213.69.31.130]:51214 "EHLO
	mail-klh.telecentrum.de") by vger.kernel.org with ESMTP
	id <S267876AbRGRN2u>; Wed, 18 Jul 2001 09:28:50 -0400
Message-ID: <3B55756E.F3947FD9@topit.de>
Date: Wed, 18 Jul 2001 13:39:26 +0200
From: Ronald Jeninga <rj@topit.de>
Reply-To: rj@topit.de
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mdaljeet@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: ppc Linux-2.4.2 not generating core dump for SIGSEGV and abort()
In-Reply-To: <CA256A8D.0047BE63.00@d73mta01.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

you should probably check your limits. Try

ulimit -a

you'll probably have a coresize of 0 (SuSE's default I believe)
change it with

ulimit -c unlimited

(or some number, see also man ulimit).

This might help.

Ronald



mdaljeet@in.ibm.com wrote:
> 
> Hi all,
>      I am using Suse-linux-7.1 with default linux -ppc kernel on apple G4
> machine.
> SIGSEGV is never generating the core dump. though this signal is being
> caught by the user process.
> I also tried with "abort" call which should generate the core dump, but
> this is also not working. The same program with abort call is generating
> core dumps on other linux/unix platforms.
> Can anybody tell me where is the problem?
> 
> Daljeet.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
