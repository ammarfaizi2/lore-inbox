Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266574AbRHJJXS>; Fri, 10 Aug 2001 05:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRHJJXI>; Fri, 10 Aug 2001 05:23:08 -0400
Received: from hermes.hrz.uni-giessen.de ([134.176.2.15]:53925 "EHLO
	hermes.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id <S266574AbRHJJWt>; Fri, 10 Aug 2001 05:22:49 -0400
Date: Fri, 10 Aug 2001 11:22:50 +0200 (CEST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: <gc1007@fb07-calculator.math.uni-giessen.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Pavel Machek'" <pavel@suse.cz>, <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        <suse-linux@suse.com>, <suse-linux-e@suse.com>
Subject: Re: [Acpi] Re: shutdown on pressing the ATX power button
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE03A@orsmsx35.jf.intel.com>
Message-Id: <Pine.LNX.4.33.0108101103430.785-100000@fb07-calculator.math.uni-giessen.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Grover, Andrew wrote:

> Just use acpid - it should notice the power button press and do the right
> thing.

Thats exactly what I need. Thanks.

One problem I had, though. With ACPI on (and thus APM off) the system
wouldn't power off after halting. Here is the reason:

The shutdown script on my system (SuSE 7.2) looks for /proc/apm or
/proc/sys/acpi and calls 'halt -p' in both casese, else 'halt'.

Changing /proc/sys/acpi to /proc/acpi solved that last problem.
I suppose that other (older) kernel versions used /proc/sys/acpi instead
of /proc/acpi. The best solution is then to check for existence of one of
/proc/apm, /proc/sys/acpi and /proc/acpi.

Thanks again.

> -----Original Message-----
> From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
> To: linux-kernel@vger.kernel.org
>
> Hi!
>
> > is there any way to let the system execute something by  pressing the ATX
> > power button (preferrable executing 'shutdown -h now', but  would be nice
> > if it was configurable)
> >
> > I looked into the (very large) list archive but didnt find  any answer.
> > if it is a kind of FAQ or off topic, please point me to the  place I could
> > find an answer.

c ya
        Sergei

--------------------------------------------------------------------
         eMail:       Sergei.Haller@math.uni-giessen.de
--------------------------------------------------------------------
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain


