Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUA3JTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 04:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUA3JTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 04:19:48 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:64527 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S266322AbUA3JTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 04:19:47 -0500
Message-ID: <1075454335.401a217f3e0d8@imp.gcu.info>
Date: Fri, 30 Jan 2004 10:18:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] i2c driver fixes for 2.6.2-rc2
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es> <1075365845.4018c7d5353d7@imp.gcu.info> <20040129222135.GC5768@werewolf.able.es>
In-Reply-To: <20040129222135.GC5768@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "J.A. Magallon" <jamagallon@able.es>:

> w83781d-isa-0290
> (...)
> CPU0 Tmp:    +41°C  (high =    +0°C, hyst =   +64°C)   ALARM  
> CPU1 Tmp:  +44.5°C  (high =   +80°C, hyst =   +75°C)          
> (...)
> One question: is there any reference of what do temperature sensors
> measure exactly ? IE, I have a dual PII box, that temperatures are
> for both processors, one processor and the mobo, two sensors on
> different points in the mobo, ??

On the w83781d (and this is true for most similar chips), temp1 is the
chipset's own temperature, and temp2 and temp3 are remote temperatures.
What these remote sensors are configured to measure depends on your
motherboard. On a dual CPU system, I'd expect them to handle one CPU
each. If I am right, they you will want to edit /etc/sensors.conf for
proper labels and remove the "ignore temp3" statement that must be
there.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

