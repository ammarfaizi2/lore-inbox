Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVHKWIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVHKWIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVHKWIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:08:35 -0400
Received: from khc.piap.pl ([195.187.100.11]:6660 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932413AbVHKWIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:08:34 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
	<m3fytgnv73.fsf@defiant.localdomain>
	<20050811215929.1df5fab0.khali@linux-fr.org>
	<m3iryctaou.fsf@defiant.localdomain>
	<20050811234946.0106afbe.khali@linux-fr.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 12 Aug 2005 00:08:32 +0200
In-Reply-To: <20050811234946.0106afbe.khali@linux-fr.org> (Jean Delvare's
 message of "Thu, 11 Aug 2005 23:49:46 +0200")
Message-ID: <m3br44t9cv.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jean Delvare <khali@linux-fr.org> writes:

> Partly right. Actually, most SMBus controllers work the following way:
> you program a number of registers (typically SMBus transaction type,
> target chip address, target register address or command, and the data to
> send in the case of a write transaction),

So, with one transaction, can I write an arbitrary number of bytes to
the device, and then, in the same transaction, can I read one (or no,
or with some controllers, more than one) byte(s) back?

>> But wait, even then does the controller really know anything about
>> I^2C commands? How would it differentiate between, say, 8-bit and
>> 16-bit reads? Or is it just an 8-bit EEPROM bus?
>
> No, it is still physically a 2-wire serial bus.

Sure, I rather meant "a bus _for_ I^2C EEPROMs which use 8-bit (+3)
addressing".

> The limitation is due to
> the fast that the SMBus controller knows of a limited number of
> transactions, such as Send Byte, Read Byte, Read Word etc. If the SMBus
> controller doesn't know of the SMBus command you want to use (in my
> case, I2C block read), then there is no way to do it, because we have no
> direct control over the serial line.

Interesting. Still, that limits it to 8-bit-addressable EEPROMs.

Are such things documented somewhere on the net (some datasheet maybe)?
-- 
Krzysztof Halasa
