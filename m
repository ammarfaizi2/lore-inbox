Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUD0PCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUD0PCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbUD0PCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:02:03 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:56741 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264170AbUD0PB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:01:58 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Tue, 27 Apr 2004 17:01:44 +0200
From: stefan.eletzhofer@eletztrick.de
To: linux-kernel@vger.kernel.org
Subject: i2c_get_client() missing?
Message-ID: <20040427150144.GA2517@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm in the process of porting my Epson 8564 RTC chip from 2.4 to
2.6.6-rc2. This is a RTC chip sitting on a I2C bus.

The code is here:
http://213.239.196.168/~seletz/patches/2.6.6-rc2/i2c-rtc8564.patch
http://213.239.196.168/~seletz/patches/2.6.6-rc2/machine-raalpha-rtc.patch

In order to split up functionality (I2C bus access and RTC misc device
stuff) I wrote two separate modules. In the rtc code module I did a i2c_get_client()
with the ID of my RTC chip to get a struct i2c_client which I think I need to
talk to the chip. I've implemented the command callback in my I2C module, which
I want to call from my RTC module.

Now I find that in 2.6.6-rc2 the i2c_get_client() implementation is missing (the prototype
is still in linux/i2c.h). Even the docs for i2c_use_client() refer to that function.

Most probably I'm missing something, but how is one supposed to access a i2c-client's
command function when i2c_get_client() is missing?

Of course I could just merge these two drivers and forget about separating i2c chip
access and rtc stuff, but ...

Thanks,
	Stefan E.

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
