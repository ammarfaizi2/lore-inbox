Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVCJI4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVCJI4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCJI4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:56:03 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:24319 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262459AbVCJIzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:55:36 -0500
Date: Thu, 10 Mar 2005 09:52:50 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <XO42l8mC.1110444770.5508140.khali@localhost>
In-Reply-To: <200503091927.24558.gene.heskett@verizon.net>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Andrew Morton" <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       video4linux-list@redhat.com, sensors@stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gene,

> > I've dropped the "id" member of struct i2c_client, as it were
> > useless. Third-party driver authors now need to do the same.
>
> Aha!  As in just 'dd' any line containing the .id in vim?

Exactly. Don't kill all lines with .id though, only the i2c_client id
was dropped, and there are plenty of other ids in the media/video
drivers.

> > THRM is most likely a temperature you get from
> > /proc/acpi/thermal_zone, and isn't related with the w83627hf
> > driver.
>
> Humm, it is the highest temp reported, as is temp2 in gkrellm, so I
> had assumed it was somehow a dup of the diode in the cpu, or of the
> thermistor against the bottom of it inside the socket.  Wrong
> assumption?

Not necessarily wrong. It is possible that the same diode temperature is
read from the W83627HF chip by both the ACPI subsystem and by the
w83627hf driver. But if this is the case, I would be worried by
concurrent I/O accesses to the chip, which could possibly cause trouble.

--
Jean Delvare
