Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSBCMBu>; Sun, 3 Feb 2002 07:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSBCMBk>; Sun, 3 Feb 2002 07:01:40 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:65262 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S286925AbSBCMBW>; Sun, 3 Feb 2002 07:01:22 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1012705104.774.4.camel@thanatos> 
In-Reply-To: <1012705104.774.4.camel@thanatos> 
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: apm.c and multiple battery slots 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Feb 2002 12:01:19 +0000
Message-ID: <12638.1012737679@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jdthood@mail.com said:
> > Then we could add one line for each battery slot,
> > indicating <battery status> <battery flag> <battery left % >
> > <remaining time in seconds>

> How about putting each of these lines in a separate proc file?  This
> would avoid changing the format of /proc/apm, which would break
> things.

Please don't add an APM-specific interface for batteries. Look at the other
code which talks to batteries - the ACPI code, SMBus and numerous other
drivers for embedded systems - and design an interface to userspace which
can be used by all of them.

Preferably not in /proc.

--
dwmw2


