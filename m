Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSGNWw7>; Sun, 14 Jul 2002 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSGNWw6>; Sun, 14 Jul 2002 18:52:58 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:2775
	"EHLO awak") by vger.kernel.org with ESMTP id <S317194AbSGNWw6> convert rfc822-to-8bit;
	Sun, 14 Jul 2002 18:52:58 -0400
Subject: Re: apm power_off on smp
From: Xavier Bestel <xavier.bestel@free.fr>
To: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200207141730.08342.kelledin+LKML@skarpsey.dyndns.org>
References: <Pine.GSO.4.30.0207150010030.27346-100000@balu> 
	<200207141730.08342.kelledin+LKML@skarpsey.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 15 Jul 2002 00:55:38 +0200
Message-Id: <1026687339.2077.15.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 15/07/2002 à 00:30, Kelledin a écrit :
> > APM's poweroff function is explicitly turned off on smp systems by
> > default. Could someone tell me please what is the reason for that?
> 
> (as of kernel 2.4.18) pretty much *all* APM functions are disabled on SMP 
> kernels--the simple reason being that APM isn't SMP safe, and making it SMP 
> safe is not a trivial task.
> 
> If all you want is a soft power-off, you're better off using ACPI (assuming 
> your system supports it).  Since this is probably a desktop (and not a 
> laptop), I doubt there's much else you want in the way of power management...

ACPI is still very broken for some chipsets (VIA 686b), while apm works
well for this task (powering off a machine doesn't need much SMP
protection).

