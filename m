Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266943AbSK2D1r>; Thu, 28 Nov 2002 22:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSK2D1r>; Thu, 28 Nov 2002 22:27:47 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:50436
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S266943AbSK2D1q>; Thu, 28 Nov 2002 22:27:46 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][TRIVIAL][PATCH][2.5] - Supplimental fix to ACPI_SLEEP & SOFTWARE_SUSPEND compile issue
Date: Thu, 28 Nov 2002 22:36:20 -0500
User-Agent: KMail/1.5
Cc: Andrew Grover <andrew.grover@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <200211232206.58081.spstarr@sh0n.net>
In-Reply-To: <200211232206.58081.spstarr@sh0n.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211282236.20179.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This still has problems. Unless kbuild can force an option always on when 
another dependency is selected. You will get compile errors.

Solutions?

On November 23, 2002 10:06 pm, Shawn Starr wrote:
> This patch should fix remaining issues regarding compiling ACPI Sleep
> states with Software suspend. You need to enable ACPI_SLEEP in config to
> use software suspend.
>
> The problem is, kbuild doesn't seem to allow this (right?). if ACPI_SLEEP
> is enabled it will allow you to select SOFTWARE_SUSPEND but if you uncheck
> SOFTWARE_SUSPEND it doesn't disable ACPI_SLEEP which IMHO it should not be
> because sleeping the system doesn't always mean power off. Standby might be
> a sleep state too.
>
> Here's the patch, please comment :)
>
> Shawn.
>
> From Pavel:
> > > Could you make it so that CONFIG_ACPI_SLEEP is not selectable without
> > > CONFIG_SOFTWARE_SUSPEND  and move CONFIG_SOFTWARE_SUSPEND into "power
> > > managment" submenu?
> > >                                                             Pavel

