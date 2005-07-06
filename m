Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVGFOh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVGFOh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVGFOeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:34:23 -0400
Received: from [203.171.93.254] ([203.171.93.254]:27282 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262298AbVGFKRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:17:13 -0400
Subject: Re: [PATCH] [2/48] Suspend2 2.1.9.8 for 2.6.12:
	300-reboot-handler-hook.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@gmail.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f02050706030846183451@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164392618@foobar.com>
	 <84144f02050706030846183451@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120645104.4860.68.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 20:18:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 20:08, Pekka Enberg wrote:
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > diff -ruNp 301-proc-acpi-sleep-activate-hook.patch-old/drivers/acpi/sleep/proc.c 301-proc-acpi-sleep-activate-hook.patch-new/drivers/acpi/sleep/proc.c
> > --- 301-proc-acpi-sleep-activate-hook.patch-old/drivers/acpi/sleep/proc.c       2005-06-20 11:46:50.000000000 +1000
> > +++ 301-proc-acpi-sleep-activate-hook.patch-new/drivers/acpi/sleep/proc.c       2005-07-04 23:14:18.000000000 +1000
> > @@ -68,6 +68,17 @@ acpi_system_write_sleep (
> >                 goto Done;
> >         }
> >         state = simple_strtoul(str, NULL, 0);
> > +#ifdef CONFIG_SUSPEND2
> > +       /*
> > +        * I used to put this after the CONFIG_SOFTWARE_SUSPEND
> > +        * test, but people who compile in suspend2 usually want
> > +        * to use it instead of swsusp.   --NC
> > +        */
> > +       if (state == 4) {
> 
> enum for states instead of magics, please.

Changed to ACPI_STATE_S4. Thanks!

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

