Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279576AbRJXTlq>; Wed, 24 Oct 2001 15:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279584AbRJXTlg>; Wed, 24 Oct 2001 15:41:36 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:58811 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S279576AbRJXTlT>; Wed, 24 Oct 2001 15:41:19 -0400
Posted-Date: Wed, 24 Oct 2001 21:34:25 +0100 (WEST)
Date: Wed, 24 Oct 2001 21:47:59 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200110241947.VAA06892@db0bm.ampr.org>
To: alan@lxorguk.ukuu.org.uk, cks@utcc.utoronto.ca,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac, lm-sensors broken ??
Cc: safemode@speakeasy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>> So I've done : get rid of the external i2c package, compiled the built-in
>> i2c stack. make and make install for the lm_sensors (2.6.1)...
>> ... It does not work

>Nobody is having this problem but you.   have you tried insmoding the
>w83781d-isa-0290's module manually if it's not loaded? what version of
>lm-sensors are you using?

As I wrote, version is 2.6.1
w83781d-isa-0290, there is _no_ modules with this name !
The needed modules are i2c-core, i2c-isa, i2c-proc, w83781d. They are loaded.


...................

>Try turning off PnPBIOS support, which is new in -ac. That did it for
> me.
 
This is the clue. Without PnPBIOS enabled, the sensors work again. Thanks.


Alan, is there any known incompatiblity between PnPBIOS and the lm-sensors ?

----------
Regards
		Jean-Luc
