Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSBJKOl>; Sun, 10 Feb 2002 05:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289492AbSBJKOa>; Sun, 10 Feb 2002 05:14:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289487AbSBJKOU>;
	Sun, 10 Feb 2002 05:14:20 -0500
Message-ID: <3C6647BB.A69310BA@zip.com.au>
Date: Sun, 10 Feb 2002 02:13:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paule@ilu.vu
CC: Chris Ball <chris@void.printf.net>, linux-kernel@vger.kernel.org
Subject: Re: 3com pcmcia modules.
In-Reply-To: <20020209151533.A644@ilu.vu> <877kpmvetv.fsf@lexis.house.pkl.net>, <877kpmvetv.fsf@lexis.house.pkl.net>; <20020209160407.A1222@ilu.vu> <3C6584F3.D571C1CB@zip.com.au> <20020209220805.A383@ilu.vu>,
		<20020209220805.A383@ilu.vu>; from paule@ilu.vu on Sat, Feb 09, 2002 at 10:08:05PM +0000 <20020210095940.A1147@ilu.vu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paule@ilu.vu wrote:
> 
> An old problem has re-appeared since I have done this,
> On a soft-reboot ('reboot / shutdown -r now') the kernel
> stops on its way back up stating
> Socket Status 0x0000003
> 
> (or something similar)
> and it then requires a hard-reset to clear.
> This only seems to be under the 3c59x code / more-so the vortex module.

IRQ storm on the Cardbus controller, probably.

Try the pcmcia-ip-autoconf and yenta-hack patches at
http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/

-
