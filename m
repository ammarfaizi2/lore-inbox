Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbRFBA0q>; Fri, 1 Jun 2001 20:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbRFBA0h>; Fri, 1 Jun 2001 20:26:37 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:24990 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S261956AbRFBA0c>; Fri, 1 Jun 2001 20:26:32 -0400
Message-ID: <3B183297.4D8F77F0@pp.inet.fi>
Date: Sat, 02 Jun 2001 03:25:59 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: L Larssen <rescue_disk_13@usa.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: international patches from kerneli far behind
In-Reply-To: <20010601201659.9930.qmail@nwcst337.netaddress.usa.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L Larssen wrote:
> Sorry if this subject does not fit in this list.
> I am a bit worried about the development of the international kernel patches
> from kerneli.org.
> 
> These patches are getting far behind on the real kernel distributions.
> At this moment the latest patches are 2.2.18.3 and 2.4.3.1 while the kernel at
> now is at 2.2.19 and 2.4.5.
> 
> There is now news to the public why these patches are falling behind.
> 
> I hope more people are consirned about this.

International crypto patch is misdesigned and broken, period. Block device
drivers are supposed handle varying transfer sizes, international crypto
patch doesn't. Loop device transfers are supposed to be re-entrant,
international crypto patch transfers are not. Summary: international crypto
patch will corrupt your data. Avoid using it.

If you don't want to play russian roulette with your data, you should
consider using loop-AES package. loop-AES announcement is here:

    http://mail.nl.linux.org/linux-crypto/2001-05/msg00003.html
    http://marc.theaimsgroup.com/?l=linux-crypto&m=98923954103730&w=2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
