Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbTC0NTW>; Thu, 27 Mar 2003 08:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbTC0NTW>; Thu, 27 Mar 2003 08:19:22 -0500
Received: from smtp-101.noc.nerim.net ([62.4.17.101]:43023 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S262546AbTC0NTV>; Thu, 27 Mar 2003 08:19:21 -0500
Date: Thu, 27 Mar 2003 14:31:40 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: azarah@gentoo.org, greg@kroah.com, mds@paradyne.com,
       linux-kernel@vger.kernel.org, linux@brodo.de,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-Id: <20030327143140.0428fcd7.khali@linux-fr.org>
In-Reply-To: <3E82F736.2000704@portrix.net>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	<20030325175603.GG15823@kroah.com>
	<1048705473.7569.10.camel@nosferatu.lan>
	<3E82024A.4000809@portrix.net>
	<20030326202622.GJ24689@kroah.com>
	<3E82292E.536D9196@paradyne.com>
	<20030326225234.GA27436@kroah.com>
	<3E82D678.9000807@portrix.net>
	<1048762244.4773.1258.camel@workshop.saharact.lan>
	<3E82EE25.3070308@portrix.net>
	<1048768432.4774.1263.camel@workshop.saharact.lan>
	<3E82F736.2000704@portrix.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, and I don't want to do small corrections like 1 or 2 percent up or
> or down, but things like this for lm80:
>      compute in0 (24/14.7 + 1) * @ ,       @ / (24/14.7 + 1)
>      compute in2 (22.1/30 + 1) * @ ,       @ / (22.1/30 + 1)
>      compute in3 (2.8/1.9) * @,            @ * 1.9/2.8
>      compute in4 (160/30.1 + 1) * @,       @ / (160/30.1 + 1)
> 
> These differ a lot. And as stated in the sensors.conf seem to be from 
> the datasheet of the lm80 and not mainboard specific.

They may be mainboard specific. The formulae rely on *suggested*
resistor values, which the integrators may or may not follow. There
definitely is a need for userspace conversion. Libsensors needs to be
tunable by the user.

I don't know about the kernel conversion Jan is talking about (never
coded a sensor driver myself), so I can't talk about this half, but I'm
pretty sure you shouldn't even think of moving all conversions into
kernel space.

Mark, Phil, maybe you could explain the reasons better than I would?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
