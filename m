Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTIQTQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbTIQTQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:16:07 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:45539 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S262785AbTIQTQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:16:03 -0400
Date: Wed, 17 Sep 2003 21:15:34 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: HELP PLEASE: i2c in interrupt?
Message-ID: <20030917191534.GB19425@oasis.frogfoot.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux Kernel Discussions <linux-kernel@vger.kernel.org>
References: <20030917181138.GA18892@oasis.frogfoot.net> <Pine.LNX.4.53.0309171424220.148@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309171424220.148@chaos>
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 21:08:54 up 29 days, 2:24, 9 users, load average: 0.04, 0.03, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard                                       >@2003.09.17_20:45:41_+0200

> Why do you need something different? Why do you have something
> on the timer queue in the first place? You don't need anything
> like that. Serial I/O is serial I/O. You handle the IIC bus
> serial I/O just like RS-232C or keyboard input. You get an
> interrupt, the ISR gets the data and puts it in a buffer.

See, that's my problem. The ISR can't put it in a buffer, because in order
to read the data it has to sleep. The reason for that as I explained it is
that it has to read the data from a chip on an I2C bus.

-- 

Regards
 Abraham

Heller's Law:
	The first myth of management is that it exists.

Johnson's Corollary:
	Nobody really knows what is going on anywhere within the
	organization.

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

