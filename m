Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbSKPFGB>; Sat, 16 Nov 2002 00:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbSKPFGB>; Sat, 16 Nov 2002 00:06:01 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.11.87]:6148
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267219AbSKPFGA>; Sat, 16 Nov 2002 00:06:00 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] Fix drivers/acpi/sleep.c compile error if swsusp is disabled
Date: Sat, 16 Nov 2002 00:12:53 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200211132304.03608.spstarr@sh0n.net> <20021114225922.GA1334@elf.ucw.cz>
In-Reply-To: <20021114225922.GA1334@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211160012.53649.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can fix this, sure. I'll have a fix later today or so.

On November 14, 2002 05:59 pm, Pavel Machek wrote:
> Hi!
>
> > Hi, this should fix this compile problem (if this is correct).
> >
> > Please apply.
>
> It would silently do nothing, that's bad.
>
> Could you make it so that CONFIG_ACPI_SLEEP is not selectable without
> CONFIG_SOFTWARE_SUSPEND  and move CONFIG_SOFTWARE_SUSPEND into "power
> managment" submenu?
> 								Pavel
>
> >                 break;
> >
> >         case ACPI_STATE_S2:
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> >         case ACPI_STATE_S3:
> >                 do_suspend_lowlevel(0);
> > +#endif
> >                 break;
> >         }
> >         local_irq_restore(flags);

