Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290761AbSAYSWW>; Fri, 25 Jan 2002 13:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290766AbSAYSWC>; Fri, 25 Jan 2002 13:22:02 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:33805
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S290761AbSAYSVw>; Fri, 25 Jan 2002 13:21:52 -0500
Date: Fri, 25 Jan 2002 19:21:48 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] SiS 2.4 IDE driver update (+= ATA16|ATA33|ATA100)
Message-ID: <20020125192148.A21145@bouton.inet6-interne.fr>
Mail-Followup-To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020125172155.A11517@bouton.inet6-interne.fr> <Pine.GSO.4.21.0201251942130.19355-200000@skiathos.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201251942130.19355-200000@skiathos.physics.auth.gr>; from kostas@skiathos.physics.auth.gr on Fri, Jan 25, 2002 at 08:02:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 08:02:43PM +0200, Liakakis Kostas wrote:
> 
> Well, success :-)
> Stock 2.4.17 doesn't hang any more :-)
> 

Cool.

> One question though, hdparm -i/I says my drive is udma2 (UDMA/33 isnt it?)
> capable. Why don't I get it on boot? (or is my chipset UDMA/33 capable?).

Don't think so. IIRC (don't have the specs right now at hand) SiS5513 isn't UDMA capable.

> hdparm -X66 /dev/hda hangs the machine completely. Same with 65 and 64.

If I'm correct with UDMA above, this is expected behavior...
I don't know the IDE framework and hdparm enough yet to know if I can trap hdparm
actions at the chip driver level... it may speak (and I believe it to do so) to the drives directly.

> The debug messages that appear when I do so say:
> 
> sis5513_tune_chipset start, changed registers: none 
> sis5513_tune_chipset ,drive 0, speed 66
> sis5513_tune_chipset end, changed registers: none
> 
> Attached is the boot time debug info.

Many thanks. My database of BIOS init behaviour will grow, this is *good*.

I'm mostly away (Palm with GSM is kind of... slow) from Net access this week-end and I'll be away too from tuesday
on next week. So don't be surprised if I don't answer bug reports or
enhancement requests in the following days, be patient and don't hesitate
to repost your message if you don't have any answer February the 6.

LB.
