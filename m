Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbUDRFb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUDRFb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:31:58 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:3344 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264130AbUDRFb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:31:56 -0400
Date: Sun, 18 Apr 2004 07:32:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Ian Morgan <imorgan@webcon.ca>
Cc: helpdeskie@bencastricum.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 Sensors & USB problems
Message-Id: <20040418073210.17898929.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.58.0404171756400.11374@dark.webcon.ca>
References: <1081349796.407416a4c3739@imp.gcu.info>
	<Pine.LNX.4.58.0404171756400.11374@dark.webcon.ca>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 2.6.5-rc1 -> sensors broke (ERROR: Can't get <sensor> data!)
> > 
> > Your sensors problem will be resolved as soon as you switch to the
> > just released lm_sensors 2.8.6.
> 
> I use the same w83781d and i2c_i801 drivers on my Asus P4PE box, and
> they too went belly up with 2.6.5. However, I HAVE tried lm_sensors
> 2.8.6 and that made no difference. They're just user-space tools that
> don't touch the kernel any more in 2.6.x (right?).
> 
> The problem I am seeing now in 2.6.5 is that after loading the w83781d
> module, nothing shows up in /sys or /proc, as though the module had
> not loaded but lsmod says it is loaded.
> 
> In 2.6.4, my sensors showed up hare:
> /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002d/* (w83781d)
> /sys/devices/pci0000:00/0000:00:1f.3/i2c-1/1-0050/* (eeprom)
> 
> Now in 2.6.5, with both eeprom and w83781d modules loaded, I only get
> the eeprom, and the w83781d is nowhere to be found:
> /sys/devices/pci0000:00/0000:00:1f.3/i2c-1/1-0050/* (eeprom)

This is a different problem, and I agree that upgrading user-space tools
couldn't help in you case. Ben had his chip correctly detected but the
interface exported by the kernel was not known to the (not up-to-date)
user-space tools. In you case this is the kernel driver not supporting
your hardware anymore, that's different.

See my answer to your second post for details about your case.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
