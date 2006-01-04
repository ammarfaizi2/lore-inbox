Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWADJw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWADJw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWADJw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:52:56 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:64220 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751602AbWADJwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:52:55 -0500
To: "Andrew Morton" <akpm@osdl.org>, "Jiri Slaby" <xslaby@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 1/4] media-radio: Pci probing for maestro radio
References: <200500919343.923456789ble@anxur.fi.muni.cz> <20051231161634.422661E32EE@anxur.fi.muni.cz> <20060104014532.3909a51e.akpm@osdl.org>
Message-ID: <op.s2ulovh1q5yxc3@merlin>
Date: Wed, 04 Jan 2006 10:51:57 +0100
From: =?iso-8859-2?B?QWRhbSBUbGGza2E=?= <atlka@pg.gda.pl>
Organization: =?iso-8859-2?B?R2Rh8XNrIFVuaXZlcnNpdHkgb2YgVGVjaG5vbG9neQ==?=
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060104014532.3909a51e.akpm@osdl.org>
User-Agent: Opera M2/8.51 (Linux, build 1462)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 04-01-2006 o 10:45:32 Andrew Morton <akpm@osdl.org> napisa³:

> "Jiri Slaby" <xslaby@fi.muni.cz> wrote:
>>
>> +	retval = video_register_device(maestro_radio_inst, VFL_TYPE_RADIO,
>>  +		radio_nr);
>>  +	if (retval) {
>>  +		printk(KERN_ERR "can't register video device!\n");
>>  +		goto errfr1;
>>  +	}
>>  +
>>  +	if (!radio_power_on(radio_unit)) {
>>  +		retval = -EIO;
>
> Shouldn't we unregister the video device here?

Current behaviour means that device is here but not functioning properly  
but
we can unregister it of course because it is useless anyway ;-).

Regards
-- 
Adam Tla³ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
