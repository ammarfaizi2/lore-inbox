Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWDSXCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWDSXCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWDSXCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:02:33 -0400
Received: from khc.piap.pl ([195.187.100.11]:40204 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751310AbWDSXCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:02:32 -0400
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Green <andy@warmcat.com>,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>
	<m3odz9kze6.fsf@defiant.localdomain>
	<m364l5dep9.fsf@defiant.localdomain> <44469BA3.2090309@sh.cvut.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 20 Apr 2006 01:02:25 +0200
In-Reply-To: <44469BA3.2090309@sh.cvut.cz> (Rudolf Marek's message of "Wed, 19 Apr 2006 22:20:51 +0200")
Message-ID: <m3r73t6uf2.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Marek <r.marek@sh.cvut.cz> writes:

>> No wonder my first attempt with 24C16 which occupies all 0x50 - 0x57
>> addresses had to fail.
>
> Hm that should work, because Asus most likely multiplexes physical lines
> instead of devices (using 74HC4052 IIRC)

No, the motherboard thought that my 24C16 was a set of 3 DIMMs
(answering at 0x50 - 0x57, and DIMMs seem to be at 0x50, 0x51 and 0x52).
Of course the data read back was some product of both DIMM EEPROM and
my 24C16 but the machine didn't pass POST.

I think anyone trying to connect an EEPROM to SMBus has to make sure
there is nothing there, and nothing is expected by things like BIOS.
Not a very plug and play.

> What about to connect the device to parallel port, there are some adapter
> schematics in kernel docs.

Sure, that's one of the options.
-- 
Krzysztof Halasa
