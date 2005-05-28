Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVE1RKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVE1RKC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 13:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVE1RKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 13:10:02 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:23310 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261168AbVE1RJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 13:09:59 -0400
Date: Sat, 28 May 2005 19:10:39 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I2C EEPROM write access
Message-Id: <20050528191039.6f2bfa96.khali@linux-fr.org>
In-Reply-To: <20050525125609.GA15412@kestrel.twibright.com>
References: <20050525125609.GA15412@kestrel.twibright.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

Sorry for the delay.

> Is it possible to use some Linux I2C driver to program an I2C EEPROM,
> for example 24C16?

I don't think there is a driver for that. A driver isn't the only
solution to do that though.

> I have noticed only read-only access to "DIMM eeproms". Are they
> 24C16-alike?

The eeprom driver supports the 24C01, 24C02, 24C04, 24C08 and 24C16. In
other words, all models which can be read using SMBus read byte data
commands.

> Is there some reason why write driver is not present like users could
> inadvertently overwrite their DIMM eeproms?

Exactly.

> Do these eeproms have a protection against write?

Some have, but that's unrelated.

> I am mainly interested in an application where 24C16 is in-circuit
> connected to a PC and contents read and wrote (typically poking
> at firmware configuration of various devices).

You may want to look at the prog/eepromer directory of the lm_sensors
project. We have a set of user-space tools to write to EEPROMs of
various sizes. They rely on the i2c-dev driver as the user-space/kernel
interface.

-- 
Jean Delvare
