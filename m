Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVB0SwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVB0SwH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVB0SwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 13:52:07 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:10001 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261456AbVB0SwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 13:52:04 -0500
Date: Sun, 27 Feb 2005 19:52:26 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] possible bug in i2c-algo-bit's inb function
Message-Id: <20050227195226.23aa5a51.khali@linux-fr.org>
In-Reply-To: <1109528034.4564.16.camel@localhost.localdomain>
References: <E1D5GN2-0000Bi-KG@localhost.localdomain>
	<20050227103538.218fa1b0.khali@linux-fr.org>
	<1109528034.4564.16.camel@localhost.localdomain>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> Here's my I2C code:
> (...)

Looks sane.

> The bus master is a so called Pluto2 by SCM (part of a DVB-T card sold
> by Satelco). If this is a hardware bug, is it possible to add a flag
> to struct i2c_algo_bit_data to workaround this bug?

I would try to find out whether the culprit is setscl or getsda
(assuming I am correct and either of these actually is the problem).
Once you know which it is, you could modifiy that function to restore
the SDA line, that should do the trick.

Hope that helps,
-- 
Jean Delvare
