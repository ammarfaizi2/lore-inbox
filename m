Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSGNW1J>; Sun, 14 Jul 2002 18:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSGNW1I>; Sun, 14 Jul 2002 18:27:08 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:1040 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S317261AbSGNW1I> convert rfc822-to-8bit; Sun, 14 Jul 2002 18:27:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: apm power_off on smp
Date: Sun, 14 Jul 2002 17:30:08 -0500
User-Agent: KMail/1.4.2
References: <Pine.GSO.4.30.0207150010030.27346-100000@balu>
In-Reply-To: <Pine.GSO.4.30.0207150010030.27346-100000@balu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207141730.08342.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> APM's poweroff function is explicitly turned off on smp systems by
> default. Could someone tell me please what is the reason for that?

(as of kernel 2.4.18) pretty much *all* APM functions are disabled on SMP 
kernels--the simple reason being that APM isn't SMP safe, and making it SMP 
safe is not a trivial task.

If all you want is a soft power-off, you're better off using ACPI (assuming 
your system supports it).  Since this is probably a desktop (and not a 
laptop), I doubt there's much else you want in the way of power management...

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does it still cost 
four figures to fix?"

