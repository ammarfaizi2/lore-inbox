Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbRASGYJ>; Fri, 19 Jan 2001 01:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbRASGX6>; Fri, 19 Jan 2001 01:23:58 -0500
Received: from pD905502B.dip.t-dialin.net ([217.5.80.43]:46597 "EHLO
	tron.dynodns.net") by vger.kernel.org with ESMTP id <S130144AbRASGXt>;
	Fri, 19 Jan 2001 01:23:49 -0500
Message-ID: <003701c081e0$8544f440$0601a8c0@tron>
From: "Daniel Mehrmnann" <kernel@tron.dynodns.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14JRYM-0000Ns-00@plato.bork.org> <200101190610.f0J6AUK05724@caliban.org>
Subject: Re: pppoe in 2.4.0
Date: Fri, 19 Jan 2001 07:24:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Ian Macdonald" <ianmacd@caliban.org>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, January 19, 2001 7:10 AM
Subject: Re: pppoe in 2.4.0


> On 19 Jan 2001 03:51:20 +0100 in caliban.linux.kernel, you wrote:
>
> >Does anyone have pppoe working with 2.4.0?
> >
> >I'm running 2.4.0-ac9 with ppp and pppoe compiled into the kernel
(I've
> >tried with modules too)
> >
> >The pppd simply refuses to acknowlege the presence of ppp support
in the
> >kernel.
> >The last release of pppd was in august 2000.  Was this before the
ppp
> >interface in the
> >kernel was overhauled?
>
> Have you aliased the new module name to ppp?
>
> I'm using pppd just for simple dial-up from home, but I needed to
add
> the following line to /etc/modules.conf before pppd would load the
> correct module:
>
> alias ppp ppp_async
>

Yes, PPPoE works fine with 2.4.0. PLEASE read
$YOUR_KERNEL_SOURCE/Documentation/CHANGES and setup your alias
correctly.
For example (my System):

/etc/modules.conf:

---------------cut-----------------
# Ok, here we start with 2.4.x stuff !
# LVM 0.9
alias alias block-major-58      lvm-mod
alias char-major-109            lvm-mod

#CPU
alias char-major-10-184 microcode

#PPP
alias char-major-108    ppp_generic
alias /dev/ppp          ppp_generic
alias tty-ldisc-3       ppp_async
alias tty-ldisc-14      ppp_synctty
alias ppp-compress-21   bsd_comp
alias ppp-compress-24   ppp_deflate
alias ppp-compress-26   ppp_deflate
#end 2.4.0
---------------cut--------------------

daniel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
