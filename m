Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUK0TXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUK0TXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUK0TXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:23:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34710 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261308AbUK0TXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:23:41 -0500
Date: Sat, 27 Nov 2004 20:22:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Javier Villavicencio <javierv@migraciones.gov.ar>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no entropy and no output at /dev/random  (quick question)
In-Reply-To: <41A7EDA1.5000609@migraciones.gov.ar>
Message-ID: <Pine.LNX.4.53.0411272019350.27610@yvahk01.tjqt.qr>
References: <41A7EDA1.5000609@migraciones.gov.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a server that runs kernel 2.6.9, some web and monitoring
>services, it's connected to two different networks with two different
>network cards, and somehow a php developer discovered that /dev/random
>wasn't giving any entropy to him (O_O) so i checked it out...
>[...]
>As you may see my only sources of entropy where the timer, eth0, eth1
>and the DAC960.

I doubt that timer and eth* are a non-predictable source. As such, they should
not contribute to the entropy. Better is the keyboard and/or mouse. SSH traffic
is network traffic, and if you send it to a network card, you can expect an
interrupt at <time>... prdictable.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
