Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUIUUQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUIUUQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIUUQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:16:27 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:34690 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268055AbUIUUQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:16:06 -0400
Message-ID: <9e473391040921131650943dc7@mail.gmail.com>
Date: Tue, 21 Sep 2004 16:16:03 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Michael Hunold <hunold@linuxtv.org>
Subject: Re: Adding .class field to struct i2c_client (was Re: [PATCH][2.6] Add command function to struct i2c_adapter
Cc: Jean Delvare <khali@linux-fr.org>, sensors@stimpy.netroedge.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <415067CB.1020101@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org>
	 <415067CB.1020101@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An addition to the class idea would be for clients to have priorities.
That would let me mark the bus as being for DDC. The highest priority
client would be the DDC driver. If the DDC driver can't find valid
EDID it could then fall back to letting the EEPROM driver try to find
the chip.

Something like this is important if we get a new EDID standard that
the DDC driver doesn't recognize. By letting the EEPROM driver load at
a lower priority you could still easily get to the ROM contents. Or
does it bother people if we let both EEPROM and DDC load on DDC class
buses?

-- 
Jon Smirl
jonsmirl@gmail.com
