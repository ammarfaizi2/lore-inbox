Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293012AbSCDXc0>; Mon, 4 Mar 2002 18:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293014AbSCDXcO>; Mon, 4 Mar 2002 18:32:14 -0500
Received: from 64-178-80-34.customer.algx.net ([64.178.80.34]:49397 "HELO
	mail2.there.com") by vger.kernel.org with SMTP id <S293012AbSCDXcB>;
	Mon, 4 Mar 2002 18:32:01 -0500
From: "Eric Ries" <eries@there.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FPU precision & signal handlers (bug?)
Date: Mon, 4 Mar 2002 15:31:26 -0800
Message-ID: <KPEDLFEJBNHDLFEEOIIMCELKCEAA.eries@there.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <E16i15h-0000q9-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Monday, March 04, 2002 2:38 PM
> To: Eric Ries
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: FPU precision & signal handlers (bug?)
>
>
> Think about MMX and hopefully it makes sense then.

Yes, I think I understand why this is the case presently.

> > strikes me as kind of a hack. Why should the signal handler, alone
> > among all my functions (excepting main) be responsible for blowing
> > away the control word?
>
> Right - I would expect it to be restored at the end of the signal handler
> for you - is that occuring or not ? I just want to make sure I understand
> the precise details of the problem here.

Yes, my belief is that the kernel undoes the FINIT changes by restoring the
FPU state after the signal handler returns.

Eric

