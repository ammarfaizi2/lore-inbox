Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVHKVjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVHKVjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHKVjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:39:48 -0400
Received: from khc.piap.pl ([195.187.100.11]:5380 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750990AbVHKVjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:39:48 -0400
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
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 11 Aug 2005 23:39:45 +0200
In-Reply-To: <20050811215929.1df5fab0.khali@linux-fr.org> (Jean Delvare's
 message of "Thu, 11 Aug 2005 21:59:29 +0200")
Message-ID: <m3iryctaou.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> However,
> EEPROMs are also often found on SMBus busses, those controller only
> implement a subset of all possible I2C commands.

You mean one can't drive clock and data lines at will, and the controller
(some hardware) does it instead, based on commands received from the
program (and, for example, the program interface is parallel, not 2-wire
serial). Right?

But wait, even then does the controller really know anything about
I^2C commands? How would it differentiate between, say, 8-bit and
16-bit reads? Or is it just an 8-bit EEPROM bus?

Does it do START and STOP automatically as well?

> [1] Due to an internal limitation in the Linux kernel, the maximum block
> size that can be read is actually 32 bytes, so several block reads are
> needed to retrieve larger chunks of data.

BTW: Some devices can't output all their contents in one transaction (or
with continuous byte/word read) - they are limited to one bank.
If you want to access another bank, you have to select it first.
But I think you know things like that better than me.
-- 
Krzysztof Halasa
