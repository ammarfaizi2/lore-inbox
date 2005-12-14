Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVLNJHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVLNJHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVLNJHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:07:18 -0500
Received: from sd291.sivit.org ([194.146.225.122]:53253 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S932214AbVLNJHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:07:16 -0500
Subject: Re: [PATCH] Sonypi: convert to the new platform device interface
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, malattia@linux.it, len.brown@intel.com
In-Reply-To: <20051213215711.73a79800.akpm@osdl.org>
References: <3ACA40606221794F80A5670F0AF15F840A6A9A2D@pdsmsx403>
	 <20051213215711.73a79800.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 14 Dec 2005 10:07:12 +0100
Message-Id: <1134551232.4715.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 13 décembre 2005 à 21:57 -0800, Andrew Morton a écrit :
> "Yu, Luming" <luming.yu@intel.com> wrote:
> >
> > But, from my understanding, sonypi.c should be cleanly implemented in ACPI.
> >
> 
> heh, good luck.  I've spent a decent chunk of this week making Linux suck
> less than 100% on a new Vaio, Am currently at 95%.  Poking things into
> sonypi's /proc/acpi/brightness 

this isn't sonypi's but sony_acpi's /proc/acpi/brightness

> is the only way known of controlling the
> screen brightness.  One of the mysterious and undocumented ACPI calls will
> do it, but we don't know which, nor how.

For the brightness thingy, this is known: it's the SBRT/GBRT functions
of the "SNC" ACPI device (and this seems to work for all Sony Vaios
except the ones using nvidia graphic cards, where you have to use
smartdimmer instead) 

Yu has somewhat integrated sony_acpi related functions in acpi_hotkey in
a testing patch (http://bugzilla.kernel.org/show_bug.cgi?id=4876) if you
like the proposed way to do it. Based on the existence of that patch,
the integration of sony_acpi into the offical kernel has been rejected
by ACPI people.

/me still wonders how hotkey.c got integrated into the kernel in its
current form... 

-- 
Stelian Pop <stelian@popies.net>

