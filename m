Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRJKKQi>; Thu, 11 Oct 2001 06:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275980AbRJKKQ3>; Thu, 11 Oct 2001 06:16:29 -0400
Received: from oe50.law9.hotmail.com ([64.4.8.22]:27919 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275973AbRJKKQS>;
	Thu, 11 Oct 2001 06:16:18 -0400
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Tim Waugh" <twaugh@redhat.com>, "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com> <9q3lbs$16o$1@penguin.transmeta.com> <20011011094118.M10562@redhat.com>
Subject: Re: Uhhuh.. 2.4.12
Date: Thu, 11 Oct 2001 06:14:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE50W0kKIBXEHt3V5g200000461@hotmail.com>
X-OriginalArrivalTime: 11 Oct 2001 10:16:44.0522 (UTC) FILETIME=[D3EEF4A0:01C1523D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps a quick update to the posted 2.4.12 kernel source tarball before
everyone downloads the bad one?

Or if its too late for that, 2.4.12a or 2.4.13?  :-)  (A new kernel version
out in only about an hour or so might beat the previous record.)

----- Original Message -----
From: "Tim Waugh" <twaugh@redhat.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, October 11, 2001 4:41 AM
Subject: Re: Uhhuh.. 2.4.12


> On Thu, Oct 11, 2001 at 08:30:52AM +0000, Linus Torvalds wrote:
>
> > In article
<Pine.LNX.4.33.0110110058550.1198-100000@penguin.transmeta.com>,
> > Linus Torvalds  <torvalds@transmeta.com> wrote:
> > >
> > >So I made a 2.4.12, and renamed away the sorry excuse for a kernel that
> > >2.4.11 was.
> > >
> > > - Tim Waugh: parport update
> >
> > .. which is broken.
> >
> > Not a good week.
>
> Here is the fix:
>
> --- linux/drivers/parport/ieee1284_ops.c.orig Thu Oct 11 09:40:39 2001
> +++ linux/drivers/parport/ieee1284_ops.c Thu Oct 11 09:40:42 2001
> @@ -362,7 +362,7 @@
>   } else {
>   DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
>   port->name);
> - port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
> + port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
>   }
>
>   return retval;
> @@ -394,7 +394,7 @@
>   DPRINTK (KERN_DEBUG
>   "%s: ECP direction: failed to switch forward\n",
>   port->name);
> - port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
> + port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
>   }
>
>
> Sorry guys. *blush*
>
> Tim.
> */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
